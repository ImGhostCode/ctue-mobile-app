import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/extension/data/models/favorite_model.dart';
import 'package:ctue_app/features/extension/data/models/favorite_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class FavoriteLocalDataSource {
  Future<void> cacheFavorite(
      {required ResponseDataModel<FavoriteResModel>? favoriteModel});
  Future<ResponseDataModel<FavoriteResModel>> getLastFavorites();
}

const cachedFavorite = 'CACHED_FAVORITES';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<FavoriteResModel>> getLastFavorites() {
    final jsonString = sharedPreferences.getString(cachedFavorite);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<FavoriteResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonFavorites) => jsonFavorites
              ?.map<FavoriteModel>((json) => FavoriteModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheFavorite(
      {required ResponseDataModel<FavoriteResModel>? favoriteModel}) async {
    if (favoriteModel != null) {
      sharedPreferences.setString(
        cachedFavorite,
        json.encode(Map.from({
          "data": favoriteModel.data.toJson(),
          "statusCode": favoriteModel.statusCode,
          "message": favoriteModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }
}
