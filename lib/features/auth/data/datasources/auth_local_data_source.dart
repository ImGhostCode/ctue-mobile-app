import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/login_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAccessToken({required LoginModel? loginModel});
  Future<LoginModel> getAccessToken();
}

const cachedAccessToken = 'CACHED_ACCESSTOKEN';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<LoginModel> getAccessToken() {
    final jsonString = sharedPreferences.getString(cachedAccessToken);

    if (jsonString != null) {
      return Future.value(LoginModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAccessToken({required LoginModel? loginModel}) async {
    if (loginModel != null) {
      sharedPreferences.setString(
        cachedAccessToken,
        json.encode(
          loginModel.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
