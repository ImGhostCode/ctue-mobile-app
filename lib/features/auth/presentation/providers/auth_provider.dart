import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/features/auth/business/entities/login_entity.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/auth/business/usecases/logout_usecase.dart';
import 'package:ctue_app/features/auth/business/usecases/signup_usecase.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

import '../../business/usecases/login_usecase.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthProvider extends ChangeNotifier {
  final secureStorage = SecureStorageService.secureStorage;
  LoginEntity? loginEntity;
  AccountEntity? accountEntity;
  Failure? failure;
  String? message;
  int? statusCode;
  bool isLoggedIn = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading; // Getter to access the private property

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Trigger a rebuild when the isLoading changes
  }

  AuthProvider({this.loginEntity, this.failure, this.message});

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'accessToken');
  }

  Future eitherFailureOrLogin(
      {required String email,
      required String password,
      required String fcmToken}) async {
    isLoading = true;
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
      loginParams:
          LoginParams(email: email, password: password, fcmToken: fcmToken),
    );
    failureOrLogin.fold(
      (Failure newFailure) {
        isLoading = false;
        loginEntity = null;
        failure = newFailure;
        message = newFailure.errorMessage;
        statusCode = 400;
        notifyListeners();
      },
      (ResponseDataModel<LoginEntity> loginResult) async {
        isLoading = false;
        failure = null;
        loginEntity = loginResult.data;
        message = loginResult.message;
        statusCode = loginResult.statusCode;
        await secureStorage.write(
            key: 'accessToken', value: loginResult.data.accessToken);
        isLoggedIn = true;

        notifyListeners();
      },
    );
  }

  Future eitherFailureOrLogout() async {
    isLoading = true;
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

    final failureOrLogout =
        await LogoutUsecase(authRepository: repository).call(
      logoutParams: LogoutParams(
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );
    failureOrLogout.fold(
      (Failure newFailure) {
        isLoading = false;
        message = newFailure.errorMessage;
        statusCode = 400;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<void> response) async {
        isLoading = false;
        failure = null;
        message = response.message;
        statusCode = response.statusCode;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrSignup(
      {required String name,
      required String email,
      required String password}) async {
    isLoading = true;
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
        isLoading = false;
        accountEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<AccountEntity> newAccount) {
        isLoading = false;
        failure = null;
        accountEntity = newAccount.data;
        // message = newAccessToken.message;
        notifyListeners();
      },
    );
  }
}
