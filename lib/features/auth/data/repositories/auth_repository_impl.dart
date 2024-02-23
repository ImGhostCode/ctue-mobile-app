import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/access_token_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<AccessTokenModel>>> login(
      {required LoginParams loginParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<AccessTokenModel> remoteAuth =
            await remoteDataSource.login(loginParams: loginParams);

        // localDataSource.cacheAuth(AuthToCache: remoteAuth);

        return Right(remoteAuth);
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
