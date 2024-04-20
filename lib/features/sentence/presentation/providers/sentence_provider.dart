import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/features/sentence/business/entities/sen_response_entity.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/business/usecases/cre_sentence_usecase.dart';
import 'package:ctue_app/features/sentence/business/usecases/del_sentence_usecase.dart';
import 'package:ctue_app/features/sentence/business/usecases/edit_sentence_usecase.dart';
import 'package:ctue_app/features/sentence/business/usecases/get_sen_detail_usecase.dart';
import 'package:ctue_app/features/sentence/business/usecases/get_senteces_usecase.dart';
import 'package:ctue_app/features/sentence/data/datasources/sentence_local_data_source.dart';
import 'package:ctue_app/features/sentence/data/datasources/sentence_remote_data_source.dart';
import 'package:ctue_app/features/sentence/data/repositories/sentence_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class SentenceProvider extends ChangeNotifier {
  final secureStorage = SecureStorageService.secureStorage;

  List<SentenceEntity> listSentenceEntity = [];
  SentenceEntity? sentenceEntity;
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  SentenceResEntity? sentenceResEntity;
  String? message;
  int? statusCode;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SentenceProvider({
    this.sentenceEntity,
    this.failure,
  });

  List<SentenceEntity> filteredSentences(List<int?> selectedTopics) {
    // Filter the list of sentences based on selected topic IDs
    if (selectedTopics.isNotEmpty ? selectedTopics[0] == 0 : false) {
      return sentenceResEntity!.data;
    }

    return sentenceResEntity!.data
        .where((sentence) =>
            sentence.topics!.any((topic) => selectedTopics.contains(topic.id)))
        .toList();
  }

  Future eitherFailureOrSentences(
      List<int> topics, int? type, int page, String sort) async {
    _isLoading = true;
    SentenceRepositoryImpl repository = SentenceRepositoryImpl(
      remoteDataSource: SentenceRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: SentenceLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSentence =
        await GetSentencesUsecase(sentenceRepository: repository).call(
      getSentenceParams:
          GetSentenceParams(topics: topics, type: type, page: page, sort: sort),
    );

    failureOrSentence.fold(
      (Failure newFailure) {
        _isLoading = false;

        sentenceResEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<SentenceResEntity> newSentences) {
        _isLoading = false;
        sentenceResEntity = newSentences.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrSenDetail(int id) async {
    _isLoading = true;
    SentenceRepositoryImpl repository = SentenceRepositoryImpl(
      remoteDataSource: SentenceRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: SentenceLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSentence =
        await GetSenDetailUsecase(sentenceRepository: repository).call(
      getSentenceParams: GetSentenceParams(id: id),
    );

    failureOrSentence.fold(
      (Failure newFailure) {
        _isLoading = false;

        sentenceEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<SentenceEntity> newSentence) {
        _isLoading = false;

        sentenceEntity = newSentence.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrCreSentence(
    List<dynamic> topicId,
    int typeId,
    String content,
    String meaning,
    String? note,
  ) async {
    isLoading = true;
    SentenceRepositoryImpl repository = SentenceRepositoryImpl(
      remoteDataSource: SentenceRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: SentenceLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSentence =
        await CreateSentenceUsecase(sentenceRepository: repository).call(
      createSentenceParams: CreateSentenceParams(
          topicId: topicId,
          typeId: typeId,
          content: content,
          meaning: meaning,
          note: note,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrSentence.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;

        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<SentenceEntity> newSentences) {
        isLoading = false;
        statusCode = newSentences.statusCode;
        message = newSentences.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrUpdateSentence(
    int sentenceId,
    List<dynamic> topicId,
    int typeId,
    String content,
    String meaning,
    String? note,
  ) async {
    isLoading = true;
    SentenceRepositoryImpl repository = SentenceRepositoryImpl(
      remoteDataSource: SentenceRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: SentenceLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSentence =
        await EditSentenceUsecase(sentenceRepository: repository).call(
      editSentenceParams: EditSentenceParams(
          sentenceId: sentenceId,
          topicId: topicId,
          typeId: typeId,
          content: content,
          meaning: meaning,
          note: note,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrSentence.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;

        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<SentenceEntity> newSentences) {
        isLoading = false;
        statusCode = newSentences.statusCode;
        message = newSentences.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrDelSentence(int sentenceId) async {
    isLoading = true;
    SentenceRepositoryImpl repository = SentenceRepositoryImpl(
      remoteDataSource: SentenceRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: SentenceLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrDeleteSentence =
        await DeleteSentenceUsecase(sentenceRepository: repository).call(
      deleteSentenceParams: DeleteSentenceParams(
        accessToken: await secureStorage.read(key: 'accessToken') ?? '',
        sentenceId: sentenceId,
      ),
    );
    failureOrDeleteSentence.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<void> result) {
        isLoading = false;
        statusCode = result.statusCode;
        message = result.message;
        failure = null;
        notifyListeners();
      },
    );
  }
}
