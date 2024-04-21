import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/features/topic/business/repositories/topic_repository.dart';
import 'package:ctue_app/features/topic/data/datasources/topic_local_data_source.dart';
import 'package:ctue_app/features/topic/data/datasources/topic_remote_data_source.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class TopicRepositoryImpl implements TopicRepository {
  final TopicRemoteDataSource remoteDataSource;
  final TopicLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TopicRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<TopicModel>>>> getTopics(
      {required TopicParams topicParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<TopicModel>> remoteType =
            await remoteDataSource.getTopics(topicParams: topicParams);

        localDataSource.cacheTopic(topicModel: remoteType);

        return Right(remoteType);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<TopicModel>> localTopics =
            await localDataSource.getLastTopic();
        return Right(localTopics);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }
}
