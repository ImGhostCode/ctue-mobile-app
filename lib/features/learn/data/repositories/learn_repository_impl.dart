import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_model.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_statis_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/learn_repository.dart';
import '../datasources/learn_local_data_source.dart';
import '../datasources/learn_remote_data_source.dart';

class LearnRepositoryImpl implements LearnRepository {
  final LearnRemoteDataSource remoteDataSource;
  final LearnLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LearnRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, ResponseDataModel<VocaSetStatisticsModel>>>
  //     getVocaSetStatistics(
  //         {required GetVocaSetStatisParams getVocaSetStatisParams}) async {
  //   if (await networkInfo.isConnected!) {
  //     try {
  //       ResponseDataModel<VocaSetStatisticsModel> remoteVocaSet =
  //           await remoteDataSource.getVocaSetStatistics(
  //               getVocaSetStatisParams: getVocaSetStatisParams);

  //       // localDataSource.cacheVocaSet(VocaSetToCache: remoteVocaSet);

  //       return Right(remoteVocaSet);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(
  //           errorMessage: e.errorMessage, statusCode: e.statusCode));
  //     }
  //   } else {
  //     return Left(CacheFailure(errorMessage: 'This is a network exception'));
  //   }
  // }
}
