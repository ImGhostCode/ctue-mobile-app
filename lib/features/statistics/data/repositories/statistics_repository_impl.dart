import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/data/models/contri_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/irr_verb_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/sen_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/voca_set_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/word_stat_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/statistics_repository.dart';
import '../datasources/template_local_data_source.dart';
import '../datasources/statistics_remote_data_source.dart';
import '../models/user_stat_model.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsRemoteDataSource remoteDataSource;
  final StatisticsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  StatisticsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<UserStatisticsModel>>>
      getUserStatistics({required StatisticsParams statisticsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<UserStatisticsModel> remoteStatistics =
            await remoteDataSource.getUserStatistics(
                statisticsParams: statisticsParams);

        // localDataSource.cacheAuth(AuthToCache: remoteStatistics);

        return Right(remoteStatistics);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<ContriStatisticsModel>>>
      getContriStatistics({required StatisticsParams statisticsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<ContriStatisticsModel> remoteStatistics =
            await remoteDataSource.getContriStatistics(
                statisticsParams: statisticsParams);

        // localDataSource.cacheAuth(AuthToCache: remoteStatistics);

        return Right(remoteStatistics);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<WordStatisticsModel>>>
      getWordStatistics({required StatisticsParams statisticsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<WordStatisticsModel> remoteStatistics =
            await remoteDataSource.getWordStatistics(
                statisticsParams: statisticsParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteStatistics);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<IrrVerbStatisticsModel>>>
      getIrrVerbStatistics({required StatisticsParams statisticsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<IrrVerbStatisticsModel> remoteStatistics =
            await remoteDataSource.getIrrVerbStatistics(
                statisticsParams: statisticsParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteStatistics);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<SenStatisticsModel>>>
      getSenStatistics({required StatisticsParams statisticsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<SenStatisticsModel> remoteStatistics =
            await remoteDataSource.getSenStatistics(
                statisticsParams: statisticsParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteStatistics);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<VocaSetStatisticsModel>>>
      getVocaSetStatistics({required StatisticsParams statisticsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetStatisticsModel> remoteStatistics =
            await remoteDataSource.getVocaSetStatistics(
                statisticsParams: statisticsParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteStatistics);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }
}
