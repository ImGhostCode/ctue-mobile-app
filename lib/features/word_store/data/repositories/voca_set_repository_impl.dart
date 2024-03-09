import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/word_store/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/word_store/data/models/voca_set_model.dart';
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
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> createVocaSet(
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
  Future<Either<Failure, ResponseDataModel<List<VocaSetEntity>>>>
      getUserVocaSets({required GetVocaSetParams getVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<VocaSetModel>> remoteVocaSet =
            await remoteDataSource.getUserVocaSets(
                getVocaSetParams: getVocaSetParams);

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
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> getVocaSetDetail(
      {required GetVocaSetParams getVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<VocaSetModel> remoteVocaSet = await remoteDataSource
            .getVocaSetDetail(getVocaSetParams: getVocaSetParams);

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
  Future<Either<Failure, ResponseDataModel<List<VocaSetEntity>>>> getVocaSets(
      {required GetVocaSetParams getVocaSetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<VocaSetModel>> remoteVocaSet =
            await remoteDataSource.getVocaSets(
                getVocaSetParams: getVocaSetParams);

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
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> removeVocaSet(
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
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> updateVocaSet(
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
}
