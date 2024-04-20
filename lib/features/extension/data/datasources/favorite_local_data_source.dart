import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class FavoriteLocalDataSource {
  Future<void> cacheFavorite(
      {required ResponseDataModel<List<WordModel>>? favoriteModel});
  Future<ResponseDataModel<List<WordModel>>> getLastFavorites();
}

const cachedFavorite = 'CACHED_FAVORITES';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<List<WordModel>>> getLastFavorites() {
    final jsonString = sharedPreferences.getString(cachedFavorite);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<WordModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonFavorites) => jsonFavorites
              ?.map<WordModel>((json) => WordModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheFavorite(
      {required ResponseDataModel<List<WordModel>>? favoriteModel}) async {
    if (favoriteModel != null) {
      sharedPreferences.setString(
        cachedFavorite,
        json.encode(Map.from({
          "data": favoriteModel.data.map((e) => e.toJson()).toList(),
          "statusCode": favoriteModel.statusCode,
          "message": favoriteModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }
}
