import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/auth/data/models/account_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_model.dart';

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
  Future<Either<Failure, ResponseDataModel<LoginModel>>> login(
      {required LoginParams loginParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<LoginModel> remoteAuth =
            await remoteDataSource.login(loginParams: loginParams);

        // localDataSource.cacheAuth(AuthToCache: remoteAuth);

        return Right(remoteAuth);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // LoginModel localAuth = await localDataSource.getLastAuth();
      //   return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<AccountEntity>>> signup(
      {required SignupParams signupParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<AccountModel> remoteAuth =
            await remoteDataSource.signup(signupParams: signupParams);

        // localDataSource.cacheAuth(AuthToCache: remoteAuth);

        return Right(remoteAuth);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // LoginModel localAuth = await localDataSource.getLastAuth();
      //   return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<void>>> logout(
      {required LogoutParams logoutParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<void> remoteAuth =
            await remoteDataSource.logout(logoutParams: logoutParams);

        // localDataSource.cacheAuth(AuthToCache: remoteAuth);

        return Right(remoteAuth);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // LoginModel localAuth = await localDataSource.getLastAuth();
      //   return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      // }
    }
  }
}
