import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/level/data/models/level_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class LevelLocalDataSource {
  Future<void> cacheLevel(
      {required ResponseDataModel<List<LevelModel>>? levelModel});
  Future<ResponseDataModel<List<LevelModel>>> getLastLevel();
}

const cachedLevel = 'CACHED_LEVEL';

class LevelLocalDataSourceImpl implements LevelLocalDataSource {
  final SharedPreferences sharedPreferences;

  LevelLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<List<LevelModel>>> getLastLevel() {
    final jsonString = sharedPreferences.getString(cachedLevel);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<LevelModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (item) => item
              ?.map<LevelModel>((json) => LevelModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLevel(
      {required ResponseDataModel<List<LevelModel>>? levelModel}) async {
    if (levelModel != null) {
      sharedPreferences.setString(
        cachedLevel,
        json.encode(Map.from({
          "data": levelModel.data.map((e) => e.toJson()).toList(),
          "statusCode": levelModel.statusCode,
          "message": levelModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }
}
