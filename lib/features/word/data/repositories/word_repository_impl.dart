import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/word/business/repositories/word_repository.dart';
import 'package:ctue_app/features/word/data/datasources/word_remote_data_source.dart';
import 'package:ctue_app/features/word/data/models/object_model.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class WordRepositoryImpl implements WordRepository {
  final WordRemoteDataSource remoteDataSource;
  final TemplateLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WordRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<WordModel>>>> getWords(
      {required GetWordParams getWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<WordModel>> remoteWord =
            await remoteDataSource.getWords(getWordParams: getWordParams);

        // localDataSource.cacheAuth(AuthToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<WordModel>>> getWordDetail(
      {required GetWordParams getWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<WordModel> remoteWord =
            await remoteDataSource.getWordDetail(getWordParams: getWordParams);

        // localDataSource.cacheAuth(AuthToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<List<WordModel>>>> lookupDictionary(
      {required LookUpDictionaryParams lookUpDictionaryParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<WordModel>> remoteWord = await remoteDataSource
            .lookUpDictionary(lookUpDictionaryParams: lookUpDictionaryParams);

        // localDataSource.cacheAuth(AuthToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<List<ObjectModel>>>> lookupByImage(
      {required LookUpByImageParams lookUpByImageParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<ObjectModel>> remoteWord = await remoteDataSource
            .lookUpByImage(lookUpByImageParams: lookUpByImageParams);

        // localDataSource.cacheAuth(AuthToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }
}
