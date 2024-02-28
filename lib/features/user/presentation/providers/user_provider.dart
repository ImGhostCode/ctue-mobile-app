import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/user_params.dart';

import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/user/business/usecases/get_user_usecase.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class UserProvider extends ChangeNotifier {
  UserEntity? userEntity;
  Failure? failure;
  String? message;
  bool _isLoading = false;
  bool get isLoading => _isLoading; // Getter to access the private property

  UserProvider({this.failure, this.message});

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Trigger a rebuild when the isLoading changes
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
          accessToken: await storage.read(key: 'accessToken') ?? ''),
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
        // message = newAccessToken.message;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrUpdateUser(int id, XFile? avt, String? name) async {
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

    final failureOrGetUser =
        await UpdateUserUsecase(userRepository: repository).call(
      updateUserParams: UpdateUserParams(
          accessToken: await storage.read(key: 'accessToken') ?? '',
          id: id,
          avt: avt,
          name: name),
    );
    failureOrGetUser.fold(
      (Failure newFailure) {
        // isLoading = false;
        userEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<UserEntity> newUser) {
        // isLoading = false;
        userEntity = newUser.data;
        failure = null;
        // message = newAccessToken.message;
        notifyListeners();
      },
    );
  }
}
