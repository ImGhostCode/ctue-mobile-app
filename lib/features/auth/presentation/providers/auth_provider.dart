import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/business/entities/access_token_entity.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/auth/business/usecases/signup_usecase.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

import '../../business/usecases/login_usecase.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthProvider extends ChangeNotifier {
  AccessTokenEntity? accessTokenEntity;
  AccountEntity? accountEntity;
  Failure? failure;
  String? message;

  AuthProvider({this.accessTokenEntity, this.failure, this.message});

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
      (ResponseDataModel<AccessTokenEntity> newAccessToken) {
        failure = null;
        accessTokenEntity = newAccessToken.data;
        // message = newAccessToken.message;
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
}
