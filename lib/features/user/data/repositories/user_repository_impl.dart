import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/features/auth/data/models/account_model.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:ctue_app/features/user/data/models/user_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

import '../../business/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<UserModel>>> getUser(
      {required GetUserParams getUserParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<UserModel> remoteUser =
            await remoteDataSource.getUser(getUserParams: getUserParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localUser = await localDataSource.getLastUser();
      //   return Right(localUser);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<UserEntity>>> updateUser(
      {required UpdateUserParams updateUserParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<UserModel> remoteUser = await remoteDataSource
            .updateUser(updateUserParams: updateUserParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localUser = await localDataSource.getLastUser();
      //   return Right(localUser);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<void>>> resetPassword(
      {required ResetPasswordParams resetPasswordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<void> remoteUser = await remoteDataSource
            .resetPassword(resetPasswordParams: resetPasswordParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localUser = await localDataSource.getLastUser();
      //   return Right(localUser);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<void>>> getVerifyCode(
      {required GetVerifyCodeParams getVerifyCodeParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<void> remoteUser = await remoteDataSource
            .getVerifyCode(getVerifyCodeParams: getVerifyCodeParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<UserResModel>>> getAllUser(
      {required GetAllUserParams getAllUserParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<UserResModel> remoteUser = await remoteDataSource
            .getAllUser(getAllUserParams: getAllUserParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localUser = await localDataSource.getLastUser();
      //   return Right(localUser);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<void>>> toggleBanUser(
      {required ToggleBanUserParams toggleBanUserParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<void> remoteUser = await remoteDataSource
            .toggleBanUser(toggleBanUserParams: toggleBanUserParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localUser = await localDataSource.getLastUser();
      //   return Right(localUser);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<void>>> deleteUser(
      {required DeleteUserParams deleteUserParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<void> remoteUser = await remoteDataSource.deleteUser(
            deleteUserParams: deleteUserParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localUser = await localDataSource.getLastUser();
      //   return Right(localUser);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<AccountModel>>>
      getAccountDetailByAdmin(
          {required GetAccountParams getAccountParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<AccountModel> remoteUser = await remoteDataSource
            .getAccountDetailByAdmin(getAccountParams: getAccountParams);

        // localDataSource.cacheUser(UserToCache: remoteUser);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localUser = await localDataSource.getLastUser();
      //   return Right(localUser);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }
}
