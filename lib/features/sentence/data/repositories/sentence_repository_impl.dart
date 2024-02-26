import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/business/repositories/sentece_repository.dart';
import 'package:ctue_app/features/sentence/data/datasources/sentence_remote_data_source.dart';
import 'package:ctue_app/features/sentence/data/models/sentence_model.dart';
import 'package:ctue_app/features/topic/business/repositories/topic_repository.dart';
import 'package:ctue_app/features/topic/data/datasources/topic_remote_data_source.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class SentenceRepositoryImpl implements SentenceRepository {
  final SentenceRemoteDataSource remoteDataSource;
  final TemplateLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SentenceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<SentenceModel>>>> getSentences(
      {required GetSentenceParams getSentenceParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<SentenceModel>> remoteSentence =
            await remoteDataSource.getSentences(
                getSentenceParams: getSentenceParams);

        // localDataSource.cacheAuth(AuthToCache: remoteSentence);

        return Right(remoteSentence);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localAuth = await localDataSource.getLastAuth();
      //   return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<SentenceEntity>>> getSentenceDetail(
      {required GetSentenceParams getSentenceParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<SentenceModel> remoteSentence = await remoteDataSource
            .getSentenceDetail(getSentenceParams: getSentenceParams);

        // localDataSource.cacheAuth(AuthToCache: remoteSentence);

        return Right(remoteSentence);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localAuth = await localDataSource.getLastAuth();
      //   return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }
}
