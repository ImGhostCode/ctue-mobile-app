import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';

import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/user/business/entities/user_response_entity.dart';
import 'package:ctue_app/features/user/business/usecases/del_user_usecase.dart';
import 'package:ctue_app/features/user/business/usecases/get_all_user_usecase.dart';
import 'package:ctue_app/features/user/business/usecases/get_user_usecase.dart';
import 'package:ctue_app/features/user/business/usecases/get_verify_code_usecase.dart';
import 'package:ctue_app/features/user/business/usecases/reset_pwd_usecase.dart';
import 'package:ctue_app/features/user/business/usecases/toggle_ban_user_usecase.dart';
import 'package:ctue_app/features/user/business/usecases/update_user_usecase.dart';

import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

import '../../data/datasources/user_local_data_source.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';

class UserProvider extends ChangeNotifier {
  final secureStorage = SecureStorageService.secureStorage;
  UserEntity? userEntity;
  List<AccountEntity> accounts = [];
  Failure? failure;
  String? message;
  int? statusCode;
  bool _isLoading = false;
  bool get isLoading => _isLoading; // Getter to access the private property
  UserResEntity? userResEntity;

  UserProvider({this.failure, this.message});

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Trigger a rebuild when the isLoading changes
  }

  List<int> getUserInterestTopics(bool isWord) {
    if (userEntity != null) {
      return userEntity!.interestTopics!
          .where((element) => element.isWord == isWord)
          .map((e) => e.id)
          .toList();
    }
    return [];
  }

  Future eitherFailureOrGetUser() async {
    isLoading = true;
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrGetUser =
        await GetUserUsecase(userRepository: repository).call(
      getUserParams: GetUserParams(
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );
    failureOrGetUser.fold(
      (Failure newFailure) {
        isLoading = false;
        userEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<UserEntity> newUser) {
        isLoading = false;
        userEntity = newUser.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrGetAllUser(int page) async {
    _isLoading = true;
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrGetAllUser =
        await GetAllUserUsecase(userRepository: repository).call(
      getAllUserParams: GetAllUserParams(
          page: page,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );
    failureOrGetAllUser.fold(
      (Failure newFailure) {
        _isLoading = false;
        userResEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<UserResEntity> responseDataModel) {
        _isLoading = false;
        userResEntity = responseDataModel.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrUpdateUser(
      int id, XFile? avt, String? name, List<int>? interestTopics) async {
    isLoading = true;
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrGetUser =
        await UpdateUserUsecase(userRepository: repository).call(
      updateUserParams: UpdateUserParams(
          accessToken: await secureStorage.read(key: 'accessToken') ?? '',
          id: id,
          avt: avt,
          name: name,
          interestTopics: interestTopics),
    );
    failureOrGetUser.fold(
      (Failure newFailure) {
        isLoading = false;
        userEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<UserEntity> newUser) {
        isLoading = false;
        userEntity = newUser.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrToggleBanUsr(int userId, String? feedback) async {
    isLoading = true;
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrToggleBan =
        await ToggleBanUserUsecase(userRepository: repository).call(
      toggleBanUserParams: ToggleBanUserParams(
          accessToken: await secureStorage.read(key: 'accessToken') ?? '',
          userId: userId,
          feedback: feedback),
    );
    failureOrToggleBan.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<void> result) {
        isLoading = false;
        statusCode = result.statusCode;
        message = result.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrDelUser(int userId) async {
    isLoading = true;
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrDeleteUser =
        await DeleteUserUsecase(userRepository: repository).call(
      deleteUserParams: DeleteUserParams(
        accessToken: await secureStorage.read(key: 'accessToken') ?? '',
        userId: userId,
      ),
    );
    failureOrDeleteUser.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<void> result) {
        isLoading = false;
        statusCode = result.statusCode;
        message = result.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrResetPassword(
      int code, String email, String newPassword) async {
    isLoading = true;
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrResetPassword =
        await ResetPasswordUsecase(userRepository: repository).call(
            resetPasswordParams: ResetPasswordParams(
      accessToken: await secureStorage.read(key: 'accessToken') ?? '',
      code: code,
      email: email,
      newPassword: newPassword,
    ));
    failureOrResetPassword.fold(
      (Failure newFailure) {
        isLoading = false;
        message = newFailure.errorMessage;
        statusCode = 400;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<void> res) {
        isLoading = false;
        message = res.message;
        statusCode = res.statusCode;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrGetVerifyCode(String email) async {
    // isLoading = true;
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrResetPassword =
        await GetVerifyCodeUsecase(userRepository: repository).call(
            getVerifyCodeParams: GetVerifyCodeParams(
      email: email,
    ));
    failureOrResetPassword.fold(
      (Failure newFailure) {
        // isLoading = false;
        message = newFailure.errorMessage;
        statusCode = 400;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<void> res) {
        // isLoading = false;
        message = res.message;
        statusCode = res.statusCode;
        failure = null;
        notifyListeners();
      },
    );
  }
}
