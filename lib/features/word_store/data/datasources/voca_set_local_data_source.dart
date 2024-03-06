import 'dart:convert';

import 'package:ctue_app/features/word_store/data/models/voca_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class VocaSetLocalDataSource {
  Future<void> cacheVocaSet({required VocaSetModel? templateToCache});
  Future<VocaSetModel> getLastVocaSet();
}

const cachedVocaSet = 'CACHED_TEMPLATE';

class VocaSetLocalDataSourceImpl implements VocaSetLocalDataSource {
  final SharedPreferences sharedPreferences;

  VocaSetLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<VocaSetModel> getLastVocaSet() {
    final jsonString = sharedPreferences.getString(cachedVocaSet);

    if (jsonString != null) {
      return Future.value(VocaSetModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVocaSet({required VocaSetModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedVocaSet,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
