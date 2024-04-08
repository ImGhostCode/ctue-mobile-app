import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/notification_params.dart';
import 'package:ctue_app/features/notification/business/entities/noti_response_entity.dart';
import 'package:ctue_app/features/notification/business/repositories/noti_repository.dart';
import 'package:ctue_app/features/notification/data/models/noti_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../datasources/template_local_data_source.dart';
import '../datasources/noti_remote_data_source.dart';

class NotiRepositoryImpl implements NotiRepository {
  final NotiRemoteDataSource remoteDataSource;
  final NotiLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NotiRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<NotiResEntity>>>
      getAllUserNotifications(
          {required GetAllUserNotiParams getAllUserNotiParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<NotiResModel> remoteNoti = await remoteDataSource
            .getAllUserNoti(getAllUserNotiParams: getAllUserNotiParams);

        // localDataSource.cacheNoti(NotiToCache: remoteNoti);

        return Right(remoteNoti);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localNoti = await localDataSource.getLastNoti();
      //   return Right(localNoti);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }
}
