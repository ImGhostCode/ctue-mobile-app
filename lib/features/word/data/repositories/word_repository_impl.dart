import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/business/repositories/word_repository.dart';
import 'package:ctue_app/features/word/data/datasources/word_local_data_source.dart';
import 'package:ctue_app/features/word/data/datasources/word_remote_data_source.dart';
import 'package:ctue_app/features/word/data/models/object_model.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:ctue_app/features/word/data/models/word_response_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class WordRepositoryImpl implements WordRepository {
  final WordRemoteDataSource remoteDataSource;
  final WordLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WordRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<WordResModel>>> getWords(
      {required GetWordParams getWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<WordResModel> remoteWord =
            await remoteDataSource.getWords(getWordParams: getWordParams);

        localDataSource.cacheWord(wordResModel: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<WordResModel> localWord =
            await localDataSource.getLastWord();
        return Right(localWord);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<WordModel>>> getWordDetail(
      {required GetWordParams getWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<WordModel> remoteWord =
            await remoteDataSource.getWordDetail(getWordParams: getWordParams);

        localDataSource.cacheWordDetail(wordModel: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<WordModel> localWordDetail =
            await localDataSource.getLastWordDetail();

        if (localWordDetail.data.id != getWordParams.id) {
          return Left(
              CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
        }
        return Right(localWordDetail);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
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
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
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
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<WordModel>>> createWord(
      {required CreateWordParams createWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<WordModel> remoteWord = await remoteDataSource
            .createWord(createWordParams: createWordParams);

        // localDataSource.cacheAuth(AuthToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<WordModel>>> updateWord(
      {required UpdateWordParams updateWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<WordModel> remoteWord = await remoteDataSource
            .updateWord(updateWordParams: updateWordParams);

        // localDataSource.cacheAuth(AuthToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<void>>> deleteWord(
      {required DeleteWordParams deleteWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<void> remoteWord = await remoteDataSource.deleteWord(
            deleteWordParams: deleteWordParams);

        // localDataSource.cacheAuth(AuthToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }
}
