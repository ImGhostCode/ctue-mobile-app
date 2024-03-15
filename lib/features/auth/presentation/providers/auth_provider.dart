import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/business/entities/access_token_entity.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/auth/business/entities/user_entity.dart';
import 'package:ctue_app/features/auth/business/usecases/get_user_usecase.dart';
import 'package:ctue_app/features/auth/business/usecases/signup_usecase.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

import '../../business/usecases/login_usecase.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class AuthProvider extends ChangeNotifier {
  AccessTokenEntity? accessTokenEntity;
  AccountEntity? accountEntity;
  UserEntity? userEntity;
  Failure? failure;
  String? message;
  bool isLoggedIn = false;

  AuthProvider({this.accessTokenEntity, this.failure, this.message});

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  Future eitherFailureOrLogin(
      {required String email, required String password}) async {
    AuthRepositoryImpl repository = AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: AuthLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrLogin = await LoginUsecase(authRepository: repository).call(
      loginParams: LoginParams(email: email, password: password),
    );
    failureOrLogin.fold(
      (Failure newFailure) {
        accessTokenEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<AccessTokenEntity> newAccessToken) async {
        failure = null;
        accessTokenEntity = newAccessToken.data;

        await storage.write(
            key: 'accessToken', value: newAccessToken.data.accessToken);
        isLoggedIn = true;

        notifyListeners();
      },
    );
  }

  Future eitherFailureOrSignup(
      {required String name,
      required String email,
      required String password}) async {
    AuthRepositoryImpl repository = AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: AuthLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrLogin = await SignUpUsecase(authRepository: repository).call(
      signupParams: SignupParams(name: name, email: email, password: password),
    );
    failureOrLogin.fold(
      (Failure newFailure) {
        accountEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<AccountEntity> newAccount) {
        failure = null;
        accountEntity = newAccount.data;
        // message = newAccessToken.message;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrGetUser() async {
    AuthRepositoryImpl repository = AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: AuthLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrGetUser =
        await GetUserUsecase(authRepository: repository).call(
      getUserParams: GetUserParams(
          accessToken: await storage.read(key: 'accessToken') ?? ''),
    );
    failureOrGetUser.fold(
      (Failure newFailure) {
        userEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<UserEntity> newUser) {
        userEntity = newUser.data;
        failure = null;
        // message = newAccessToken.message;
        notifyListeners();
      },
    );
  }
}
