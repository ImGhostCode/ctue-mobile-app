import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/business/usecases/get_word_detail_usecase.dart';
import 'package:ctue_app/features/word/business/usecases/get_word_usecase.dart';
import 'package:ctue_app/features/word/data/datasources/word_remote_data_source.dart';
import 'package:ctue_app/features/word/data/repositories/word_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class WordProvider extends ChangeNotifier {
  List<WordEntity>? listWordEntity = [];
  WordEntity? wordEntity;
  Failure? failure;
  bool isLoading = false;

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

  void eitherFailureOrWords(List<int> topic, List<int> type, int page,
      String sort, String key) async {
    isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
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
        isLoading = false;

        listWordEntity = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<WordEntity>> newWords) {
        isLoading = false;
        listWordEntity = newWords.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrWordDetail(int id) async {
    isLoading = true;
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
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
        isLoading = false;

        wordEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<WordEntity> newWord) {
        isLoading = false;

        wordEntity = newWord.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
