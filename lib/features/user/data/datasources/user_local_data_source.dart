import 'dart:convert';

import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser({required UserModel? accessTokenModel});
  Future<UserModel> getUser();
}

const cachedUser = 'CACHED_ACCESSTOKEN';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getUser() {
    final jsonString = sharedPreferences.getString(cachedUser);

    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser({required UserModel? accessTokenModel}) async {
    if (accessTokenModel != null) {
      sharedPreferences.setString(
        cachedUser,
        json.encode(
          accessTokenModel.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
