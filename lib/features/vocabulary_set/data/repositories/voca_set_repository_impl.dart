import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_model.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_response_model.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_statis_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/voca_set_repository.dart';
import '../datasources/voca_set_local_data_source.dart';
import '../datasources/voca_set_remote_data_source.dart';

class VocaSetRepositoryImpl implements VocaSetRepository {
  final VocaSetRemoteDataSource remoteDataSource;
  final VocaSetLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  VocaSetRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<VocaSetModel>>> createVocaSet(
      {required CreVocaSetParams creVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetModel> remoteVocaSet = await remoteDataSource
            .creVocaSet(creVocaSetParams: creVocaSetParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<List<VocaSetModel>>>>
      getUserVocaSets({required GetVocaSetParams getVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<VocaSetModel>> remoteVocaSet =
            await remoteDataSource.getUserVocaSets(
                getVocaSetParams: getVocaSetParams);

        localDataSource.cacheVocaSet(vocaSetResModel: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<VocaSetModel>> localUserVocaSets =
            await localDataSource.getLastVocaSet();
        return Right(localUserVocaSets);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a network exception'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<VocaSetModel>>> getVocaSetDetail(
      {required GetVocaSetParams getVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetModel> remoteVocaSet = await remoteDataSource
            .getVocaSetDetail(getVocaSetParams: getVocaSetParams);

        localDataSource.cacheVocaSetDetail(vocaSetResModel: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<VocaSetModel> localVocaSetDetail =
            await localDataSource.getLastVocaSetDetail();
        return Right(localVocaSetDetail);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a network exception'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<List<VocaSetModel>>>> getVocaSets(
      {required GetVocaSetParams getVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<VocaSetModel>> remoteVocaSet =
            await remoteDataSource.getVocaSets(
                getVocaSetParams: getVocaSetParams);

        localDataSource.cacheVocaSet(vocaSetResModel: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<VocaSetModel>> localVocaSets =
            await localDataSource.getLastVocaSet();
        return Right(localVocaSets);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a network exception'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<VocaSetModel>>> removeVocaSet(
      {required RemoveVocaSetParams removeVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetModel> remoteVocaSet = await remoteDataSource
            .removeVocaSet(removeVocaSetParams: removeVocaSetParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<VocaSetModel>>> updateVocaSet(
      {required UpdateVocaSetParams updateVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetModel> remoteVocaSet = await remoteDataSource
            .updateVocaSet(updateVocaSetParams: updateVocaSetParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<VocaSetModel>>> downloadVocaSet(
      {required DownloadVocaSetParams downloadVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetModel> remoteVocaSet = await remoteDataSource
            .downloadVocaSet(downloadVocaSetParams: downloadVocaSetParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

        return Right(remoteVocaSet);
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
      getVocaSetStatistics(
          {required GetVocaSetStatisParams getVocaSetStatisParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetStatisticsModel> remoteVocaSet =
            await remoteDataSource.getVocaSetStatistics(
                getVocaSetStatisParams: getVocaSetStatisParams);

        localDataSource.cacheVocaSetStatistics(
            vocaSetStatisticsResModel: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<VocaSetStatisticsModel> localUserVocaSets =
            await localDataSource.getLastVocaSetStatistics();
        return Right(localUserVocaSets);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a network exception'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<VocabularySetResModel>>>
      getVocaSetsByAdmin({required GetVocaSetParams getVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocabularySetResModel> remoteVocaSet =
            await remoteDataSource.getVocaSetsByAdmin(
                getVocaSetParams: getVocaSetParams);

        localDataSource.cacheVocaSetByAdmin(vocaSetResModel: remoteVocaSet);

        return Right(remoteVocaSet);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<VocabularySetResModel> localVocaSets =
            await localDataSource.getLastVocaSetByAdmin();
        return Right(localVocaSets);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a network exception'));
      }
    }
  }
}
