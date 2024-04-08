import 'dart:convert';

import 'package:ctue_app/features/notification/data/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class NotiLocalDataSource {
  Future<void> cacheNoti({required NotificationModel? templateToCache});
  Future<NotificationModel> getLastNoti();
}

const cachedNoti = 'CACHED_TEMPLATE';

class NotiLocalDataSourceImpl implements NotiLocalDataSource {
  final SharedPreferences sharedPreferences;

  NotiLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NotificationModel> getLastNoti() {
    final jsonString = sharedPreferences.getString(cachedNoti);

    if (jsonString != null) {
      return Future.value(
          NotificationModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNoti({required NotificationModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedNoti,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
