import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/auth/data/models/account_model.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:ctue_app/features/user/data/models/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser({required ResponseDataModel<UserModel>? userModel});
  Future<ResponseDataModel<UserModel>> getLastUser();

  Future<void> cacheAccountDetailByAdmin(
      {required ResponseDataModel<AccountModel>? accountResModel});
  Future<ResponseDataModel<AccountModel>> getLastAccountDetailByAdmin();

  Future<void> cacheUsersByAdmin(
      {required ResponseDataModel<UserResModel>? userResModel});
  Future<ResponseDataModel<UserResModel>> getLastUsersByAdmin();
}

const cachedUser = 'CACHED_USER';
const cachedAccountDetailByAdmin = 'CACHED_ACCOUNT_DETAIL_BY_ADMIN';
const cachedUsersByAdmin = 'CACHED_USERS_BY_ADMIN';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<UserModel>> getLastUser() {
    final jsonString = sharedPreferences.getString(cachedUser);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<UserModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonUser) => UserModel.fromJson(json: jsonUser)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(
      {required ResponseDataModel<UserModel>? userModel}) async {
    if (userModel != null) {
      sharedPreferences.setString(
        cachedUser,
        json.encode(
          userModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUsersByAdmin(
      {required ResponseDataModel<UserResModel>? userResModel}) async {
    if (userResModel != null) {
      sharedPreferences.setString(
        cachedUsersByAdmin,
        json.encode(
          userResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<UserResModel>> getLastUsersByAdmin() async {
    final jsonString = sharedPreferences.getString(cachedUsersByAdmin);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<UserResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonUser) => UserResModel.fromJson(json: jsonUser)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAccountDetailByAdmin(
      {required ResponseDataModel<AccountModel>? accountResModel}) async {
    if (accountResModel != null) {
      sharedPreferences.setString(
        cachedAccountDetailByAdmin,
        json.encode(
          accountResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<AccountModel>> getLastAccountDetailByAdmin() async {
    final jsonString = sharedPreferences.getString(cachedAccountDetailByAdmin);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<AccountModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonUser) => AccountModel.fromJson(json: jsonUser)));
    } else {
      throw CacheException();
    }
  }
}
