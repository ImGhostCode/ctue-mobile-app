import 'dart:convert';

import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class LearnLocalDataSource {
  Future<void> cacheLearn({required UserLearnedWordModel? templateToCache});
  Future<UserLearnedWordModel> getLastLearn();
}

const cachedLearn = 'CACHED_TEMPLATE';

class LearnLocalDataSourceImpl implements LearnLocalDataSource {
  final SharedPreferences sharedPreferences;

  LearnLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserLearnedWordModel> getLastLearn() {
    final jsonString = sharedPreferences.getString(cachedLearn);

    if (jsonString != null) {
      return Future.value(
          UserLearnedWordModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLearn(
      {required UserLearnedWordModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedLearn,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
