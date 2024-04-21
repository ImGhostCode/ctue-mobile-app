import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/level_params.dart';
import 'package:ctue_app/features/level/business/repositories/level_repository.dart';
import 'package:ctue_app/features/level/data/datasources/level_remote_data_source.dart';
import 'package:ctue_app/features/level/data/datasources/level_local_data_source.dart';
import 'package:ctue_app/features/level/data/models/level_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class LevelRepositoryImpl implements LevelRepository {
  final LevelRemoteDataSource remoteDataSource;
  final LevelLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LevelRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<LevelModel>>>> getLevels(
      {required LevelParams levelParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<LevelModel>> remoteLevel =
            await remoteDataSource.getLevels(levelParams: levelParams);

        localDataSource.cacheLevel(levelModel: remoteLevel);

        return Right(remoteLevel);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<LevelModel>> localLevels =
            await localDataSource.getLastLevel();
        return Right(localLevels);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }
}
