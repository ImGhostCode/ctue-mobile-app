import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/notification_params.dart';
import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/core/services/shared_pref_service.dart';
import 'package:ctue_app/features/notification/business/entities/noti_response_entity.dart';
import 'package:ctue_app/features/notification/business/entities/notification_entity.dart';
import 'package:ctue_app/features/notification/business/usecases/get_all_user_noti_usecase.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/datasources/template_local_data_source.dart';
import '../../data/datasources/noti_remote_data_source.dart';
import '../../data/repositories/noti_repository_impl.dart';

class NotificationProvider extends ChangeNotifier {
  final secureStorage = SecureStorageService.secureStorage;
  final prefs = SharedPrefService.prefs;
  NotificationEntity? notificationEntity;
  List<NotificationEntity> notifications = [];
  Failure? failure;
  String? message;
  int? statusCode;
  bool _isLoading = false;
  NotiResEntity? notiResEntity;
  // bool? numOfNotifications;
  bool _hasNewNoti = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;

    notifyListeners(); // Trigger a rebuild when the isLoading changes
  }

  bool get hasNewNoti {
    bool? hasNewNoti = prefs.getBool('hasNewNoti');
    if (hasNewNoti == null || !hasNewNoti) {
      _hasNewNoti = false;
      return _hasNewNoti;
    }
    _hasNewNoti = true;
    return _hasNewNoti;
  }

  set hasNewNoti(bool value) {
    prefs.setBool('hasNewNoti', value);
    _hasNewNoti = value;
    notifyListeners();
  }

  NotificationProvider({
    this.failure,
  });

  Future eitherFailureOrGetAllNotiNoti(int page) async {
    _isLoading = true;
    NotiRepositoryImpl repository = NotiRepositoryImpl(
      remoteDataSource: NotiRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: NotiLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrGetAllNoti =
        await GetAllNotiNotiUsecase(notiRepository: repository).call(
      getAllNotiNotiParams: GetAllUserNotiParams(
          page: page,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );
    failureOrGetAllNoti.fold(
      (Failure newFailure) {
        _isLoading = false;
        notiResEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<NotiResEntity> responseDataModel) {
        _isLoading = false;
        notiResEntity = responseDataModel.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
