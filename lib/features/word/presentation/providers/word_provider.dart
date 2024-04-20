import 'dart:async';

import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_response_entity.dart';
import 'package:ctue_app/features/word/business/usecases/cre_word_usecase.dart';
import 'package:ctue_app/features/word/business/usecases/del_word_usecase.dart';
import 'package:ctue_app/features/word/business/usecases/get_word_detail_usecase.dart';
import 'package:ctue_app/features/word/business/usecases/get_word_usecase.dart';
import 'package:ctue_app/features/word/business/usecases/look_up_by_image_usecase%20copy.dart';
import 'package:ctue_app/features/word/business/usecases/look_up_dic_usecase.dart';
import 'package:ctue_app/features/word/business/usecases/upd_word_usecase.dart';
import 'package:ctue_app/features/word/data/datasources/word_local_data_source.dart';
import 'package:ctue_app/features/word/data/datasources/word_remote_data_source.dart';
import 'package:ctue_app/features/word/data/repositories/word_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class WordProvider extends ChangeNotifier {
  final secureStorage = SecureStorageService.secureStorage;
  List<WordEntity>? listWordEntity = [];
  List<WordEntity> lookUpResults = [];
  List<ObjectEntity> lookUpByImageResults = [];
  WordEntity? wordEntity;
  Failure? failure;
  bool _isLoading = false;
  WordResEntity? wordResEntity;
  String? message;
  int? statusCode;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Timer? _debounce;

  WordProvider({
    this.listWordEntity,
    this.wordEntity,
    this.failure,
  });

  // List<WordEntity?> filteredWords(List<int?> selectedTopics) {
  //   // Filter the list of words based on selected topic IDs
  //   if (selectedTopics[0] == 0) return listWordEntity!;

  //   return listWordEntity!
  //       .where((word) =>
  //           word.topics!.any((topic) => selectedTopics.contains(topic.id)))
  //       .toList();
  // }

  Future eitherFailureOrWords(List<int> topic, List<int> type, int page,
      String sort, String key) async {
    _isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWord = await GetWordUsecase(wordRepository: repository).call(
      getWordParams: GetWordParams(
          topic: topic, type: type, page: page, sort: sort, key: key),
    );

    failureOrWord.fold(
      (Failure newFailure) {
        _isLoading = false;

        wordResEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<WordResEntity> newWords) {
        _isLoading = false;
        wordResEntity = newWords.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrLookUpDic(String key) async {
    // if (_debounce?.isActive ?? false) _debounce?.cancel();
    // _debounce = Timer(const Duration(milliseconds: 300), () async {
    _isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWord =
        await LookUpDicUsecase(wordRepository: repository).call(
      lookUpDictionaryParams: LookUpDictionaryParams(key: key),
    );

    failureOrWord.fold(
      (Failure newFailure) {
        _isLoading = false;
        lookUpResults = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<WordEntity>> results) {
        _isLoading = false;
        lookUpResults = results.data;
        failure = null;
        notifyListeners();
      },
    );
    // });
  }

  Future eitherFailureOrLookUpByImage(XFile file) async {
    isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWord =
        await LookUpByImageUsecase(wordRepository: repository).call(
      lookUpDictionaryParams: LookUpByImageParams(file: file),
    );

    failureOrWord.fold(
      (Failure newFailure) {
        isLoading = false;
        lookUpByImageResults = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<ObjectEntity>> results) {
        isLoading = false;
        lookUpByImageResults = results.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrWordDetail(int id) async {
    _isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWord =
        await GetWordDetailUsecase(wordRepository: repository).call(
      getWordParams: GetWordParams(id: id),
    );

    failureOrWord.fold(
      (Failure newFailure) {
        _isLoading = false;

        wordEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<WordEntity> newWord) {
        _isLoading = false;

        wordEntity = newWord.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrCreWord(
      List<dynamic> topicId,
      int levelId,
      int specializationId,
      String content,
      List<WordMeaning> meanings,
      String? note,
      String phonetic,
      List<String> examples,
      List<String> synonyms,
      List<String> antonyms,
      List<XFile> pictures) async {
    isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWord =
        await CreateWordUsecase(wordRepository: repository).call(
      createWordParams: CreateWordParams(
          topicId: topicId,
          levelId: levelId,
          specializationId: specializationId,
          content: content,
          meanings: meanings,
          note: note,
          phonetic: phonetic,
          examples: examples,
          synonyms: synonyms,
          antonyms: antonyms,
          pictures: pictures,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrWord.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;

        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<WordEntity> newWords) {
        isLoading = false;
        statusCode = newWords.statusCode;
        message = newWords.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrUpdateWord(
      int wordId,
      List<dynamic> topicId,
      int levelId,
      int specializationId,
      String content,
      List<WordMeaning> meanings,
      String? note,
      String phonetic,
      List<String> examples,
      List<String> synonyms,
      List<String> antonyms,
      List<String> oldPictures,
      List<XFile> pictures) async {
    isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWord =
        await UpdateWordUsecase(wordRepository: repository).call(
      updateWordParams: UpdateWordParams(
          wordId: wordId,
          topicId: topicId,
          levelId: levelId,
          specializationId: specializationId,
          content: content,
          meanings: meanings,
          note: note,
          phonetic: phonetic,
          examples: examples,
          synonyms: synonyms,
          antonyms: antonyms,
          oldPictures: oldPictures,
          pictures: pictures,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrWord.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;

        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<WordEntity> newWords) {
        isLoading = false;
        statusCode = newWords.statusCode;
        message = newWords.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrDelWord(int wordId) async {
    isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrDeleteWord =
        await DeleteWordUsecase(wordRepository: repository).call(
      deleteWordParams: DeleteWordParams(
        accessToken: await secureStorage.read(key: 'accessToken') ?? '',
        wordId: wordId,
      ),
    );
    failureOrDeleteWord.fold(
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
