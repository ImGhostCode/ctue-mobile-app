import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_model.dart';
import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/irr_verb_repository.dart';
import '../datasources/irr_verb_local_data_source.dart';
import '../datasources/irr_verb_remote_data_source.dart';

class IrrVerbRepositoryImpl implements IrrVerbRepository {
  final IrrVerbRemoteDataSource remoteDataSource;
  final IrrVerbLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  IrrVerbRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<IrrVerbResModel>>> getIrrVerbs(
      {required IrrVerbParams irrVerbParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<IrrVerbResModel> remoteIrrVerb =
            await remoteDataSource.getIrrVerbs(irrVerbParams: irrVerbParams);

        localDataSource.cacheIrrVerb(irrVerbResModel: remoteIrrVerb);

        return Right(remoteIrrVerb);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<IrrVerbResModel> localAuth =
            await localDataSource.getLastIrrVerb();
        return Right(localAuth);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a network exception'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<IrrVerbModel>>> createIrrVerb(
      {required CreateIrrVerbParams createIrrVerbParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<IrrVerbModel> remoteIrrVerb = await remoteDataSource
            .createIrrVerb(createIrrVerbParams: createIrrVerbParams);

        // localDataSource.cacheAuth(AuthToCache: remoteIrrVerb);

        return Right(remoteIrrVerb);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<IrrVerbModel>>> updateIrrVerb(
      {required UpdateIrrVerbParams updateIrrVerbParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<IrrVerbModel> remoteIrrVerb = await remoteDataSource
            .updateIrrVerb(updateIrrVerbParams: updateIrrVerbParams);

        // localDataSource.cacheAuth(AuthToCache: remoteIrrVerb);

        return Right(remoteIrrVerb);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<void>>> deleteIrrVerb(
      {required DeleteIrrVerbParams deleteIrrVerbParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<void> remoteIrrVerb = await remoteDataSource
            .deleteIrrVerb(deleteIrrVerbParams: deleteIrrVerbParams);

        // localDataSource.cacheAuth(AuthToCache: remoteIrrVerb);

        return Right(remoteIrrVerb);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }
}
