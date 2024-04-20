import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/notification/data/models/noti_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class NotiLocalDataSource {
  Future<void> cacheNoti(
      {required ResponseDataModel<NotiResModel>? notiResModel});
  Future<ResponseDataModel<NotiResModel>> getLastNoti();
}

const cachedNoti = 'CACHED_NOTIFICATION';

class NotiLocalDataSourceImpl implements NotiLocalDataSource {
  final SharedPreferences sharedPreferences;

  NotiLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<NotiResModel>> getLastNoti() {
    final jsonString = sharedPreferences.getString(cachedNoti);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<NotiResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonNoti) => NotiResModel.fromJson(json: jsonNoti)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNoti(
      {required ResponseDataModel<NotiResModel>? notiResModel}) async {
    if (notiResModel != null) {
      sharedPreferences.setString(
        cachedNoti,
        json.encode(
          notiResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
