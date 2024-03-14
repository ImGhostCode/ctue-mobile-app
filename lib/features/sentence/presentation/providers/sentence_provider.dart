import 'package:ctue_app/core/service/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/business/usecases/get_sen_detail_usecase.dart';
import 'package:ctue_app/features/sentence/business/usecases/get_senteces_usecase.dart';
import 'package:ctue_app/features/sentence/data/datasources/sentence_remote_data_source.dart';
import 'package:ctue_app/features/sentence/data/repositories/sentence_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class SentenceProvider extends ChangeNotifier {
  List<SentenceEntity> listSentenceEntity = [];
  SentenceEntity? sentenceEntity;
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SentenceProvider({
    this.sentenceEntity,
    this.failure,
  });

  List<SentenceEntity?> filteredSentences(List<int?> selectedTopics) {
    // Filter the list of sentences based on selected topic IDs
    if (selectedTopics.isNotEmpty ? selectedTopics[0] == 0 : false) {
      return listSentenceEntity;
    }

    return listSentenceEntity
        .where((sentence) =>
            sentence.topics!.any((topic) => selectedTopics.contains(topic.id)))
        .toList();
  }

  void eitherFailureOrSentences(
      List<int> topics, int? type, int page, String sort) async {
    _isLoading = true;
    SentenceRepositoryImpl repository = SentenceRepositoryImpl(
      remoteDataSource: SentenceRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
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

        listSentenceEntity = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<SentenceEntity>> newSentences) {
        _isLoading = false;
        listSentenceEntity = newSentences.data;
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
      localDataSource: TemplateLocalDataSourceImpl(
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
}
