import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/user_stat_model.dart';

abstract class StatisticsLocalDataSource {
  Future<void> cacheStatistics(
      {required UserStatisticsModel? userStatisticsModel});
  Future<UserStatisticsModel> getLastStatistics();
}

const cachedStatistics = 'CACHED_TEMPLATE';

class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  final SharedPreferences sharedPreferences;

  StatisticsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserStatisticsModel> getLastStatistics() {
    final jsonString = sharedPreferences.getString(cachedStatistics);

    if (jsonString != null) {
      return Future.value(
          UserStatisticsModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheStatistics(
      {required UserStatisticsModel? userStatisticsModel}) async {
    if (userStatisticsModel != null) {
      sharedPreferences.setString(
        cachedStatistics,
        json.encode(
          userStatisticsModel.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  // @override
  // Future<void> cacheStatistics(
  //     {required UserStatisticsModel? templateToCache}) async {
  //   if (templateToCache != null) {
  //     sharedPreferences.setString(
  //       cachedStatistics,
  //       json.encode(
  //         templateToCache.toJson(),
  //       ),
  //     );
  //   } else {
  //     throw CacheException();
  //   }
  // }
}
