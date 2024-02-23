import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/access_token_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAccessToken({required AccessTokenModel? accessTokenModel});
  Future<AccessTokenModel> getAccessToken();
}

const cachedAccessToken = 'CACHED_ACCESSTOKEN';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AccessTokenModel> getAccessToken() {
    final jsonString = sharedPreferences.getString(cachedAccessToken);

    if (jsonString != null) {
      return Future.value(
          AccessTokenModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAccessToken(
      {required AccessTokenModel? accessTokenModel}) async {
    if (accessTokenModel != null) {
      sharedPreferences.setString(
        cachedAccessToken,
        json.encode(
          accessTokenModel.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
