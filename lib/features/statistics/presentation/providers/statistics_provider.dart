import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/features/statistics/business/entities/contri_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/irr_verb_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/sen_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/voca_set_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/word_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/usecases/get_contri_stat_usecase.dart';
import 'package:ctue_app/features/statistics/business/usecases/get_irr_verb_stat_usecase.dart';
import 'package:ctue_app/features/statistics/business/usecases/get_sen_stat_usecase.dart';
import 'package:ctue_app/features/statistics/business/usecases/get_voca_set_stat_usecase.dart';
import 'package:ctue_app/features/statistics/business/usecases/get_word_stat_usecase.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/entities/user_stat_entity.dart';
import '../../business/usecases/get_user_stat_usecase.dart';
import '../../data/datasources/statistics_local_data_source.dart';
import '../../data/datasources/statistics_remote_data_source.dart';
import '../../data/repositories/statistics_repository_impl.dart';

class StatisticsProvider extends ChangeNotifier {
  final secureStorage = SecureStorageService.secureStorage;

  UserStatisticsEntity? userStatisticsEntity;
  ContriStatisticsEntity? contriStatisticsEntity;
  WordStatisticsEntity? wordStatisticsEntity;
  SenStatisticsEntity? senStatisticsEntity;
  IrrVerbStatisticsEntity? irrVerbStatisticsEntity;
  VocaSetStatisticsEntity? vocaSetStatisticsEntity;
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? message;
  int? statusCode;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  StatisticsProvider({
    this.failure,
  });

  Future eitherFailureOrUserStatistics(String startDate, String endDate) async {
    isLoading = true;
    StatisticsRepositoryImpl repository = StatisticsRepositoryImpl(
      remoteDataSource: StatisticsRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: StatisticsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStatistics =
        await GetUserStatistics(statisticsRepository: repository).call(
      statisticsParams: StatisticsParams(
          startDate: startDate,
          endDate: endDate,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrStatistics.fold(
      (Failure newFailure) {
        isLoading = false;
        userStatisticsEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<UserStatisticsEntity> newStatistics) {
        isLoading = false;
        userStatisticsEntity = newStatistics.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrContriStatistics(
      String startDate, String endDate) async {
    isLoading = true;
    StatisticsRepositoryImpl repository = StatisticsRepositoryImpl(
      remoteDataSource: StatisticsRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: StatisticsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStatistics =
        await GetContriStatistics(statisticsRepository: repository).call(
      statisticsParams: StatisticsParams(
          startDate: startDate,
          endDate: endDate,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrStatistics.fold(
      (Failure newFailure) {
        isLoading = false;
        contriStatisticsEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<ContriStatisticsEntity> newStatistics) {
        isLoading = false;
        contriStatisticsEntity = newStatistics.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrWordStatistics(String startDate, String endDate) async {
    isLoading = true;
    StatisticsRepositoryImpl repository = StatisticsRepositoryImpl(
      remoteDataSource: StatisticsRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: StatisticsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStatistics =
        await GetWordStatistics(statisticsRepository: repository).call(
      statisticsParams: StatisticsParams(
          startDate: startDate,
          endDate: endDate,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrStatistics.fold(
      (Failure newFailure) {
        isLoading = false;
        wordStatisticsEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<WordStatisticsEntity> newStatistics) {
        isLoading = false;
        wordStatisticsEntity = newStatistics.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrSenStatistics(String startDate, String endDate) async {
    isLoading = true;
    StatisticsRepositoryImpl repository = StatisticsRepositoryImpl(
      remoteDataSource: StatisticsRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: StatisticsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStatistics =
        await GetSenStatistics(statisticsRepository: repository).call(
      statisticsParams: StatisticsParams(
          startDate: startDate,
          endDate: endDate,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrStatistics.fold(
      (Failure newFailure) {
        isLoading = false;
        senStatisticsEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<SenStatisticsEntity> newStatistics) {
        isLoading = false;
        senStatisticsEntity = newStatistics.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrIrrVerbStatistics(
      String startDate, String endDate) async {
    isLoading = true;
    StatisticsRepositoryImpl repository = StatisticsRepositoryImpl(
      remoteDataSource: StatisticsRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: StatisticsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStatistics =
        await GetIrrVerbStatistics(statisticsRepository: repository).call(
      statisticsParams: StatisticsParams(
          startDate: startDate,
          endDate: endDate,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrStatistics.fold(
      (Failure newFailure) {
        isLoading = false;
        irrVerbStatisticsEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<IrrVerbStatisticsEntity> newStatistics) {
        isLoading = false;
        irrVerbStatisticsEntity = newStatistics.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrVocaSetStatistics(
      String startDate, String endDate) async {
    isLoading = true;
    StatisticsRepositoryImpl repository = StatisticsRepositoryImpl(
      remoteDataSource: StatisticsRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: StatisticsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStatistics =
        await GetVocaSetStatistics(statisticsRepository: repository).call(
      statisticsParams: StatisticsParams(
          startDate: startDate,
          endDate: endDate,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrStatistics.fold(
      (Failure newFailure) {
        isLoading = false;
        vocaSetStatisticsEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<VocaSetStatisticsEntity> newStatistics) {
        isLoading = false;
        vocaSetStatisticsEntity = newStatistics.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
