import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:ctue_app/features/word/data/models/word_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class WordLocalDataSource {
  Future<void> cacheWord(
      {required ResponseDataModel<WordResModel>? wordResModel});
  Future<ResponseDataModel<WordResModel>> getLastWord();
  Future<void> cacheWordDetail(
      {required ResponseDataModel<WordModel>? wordModel});
  Future<ResponseDataModel<WordModel>> getLastWordDetail();
}

const cachedWord = 'CACHED_WORD';
const cachedWordDetail = 'CACHED_WORD_DETAIL';

class WordLocalDataSourceImpl implements WordLocalDataSource {
  final SharedPreferences sharedPreferences;

  WordLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<WordResModel>> getLastWord() {
    final jsonString = sharedPreferences.getString(cachedWord);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<WordResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonWord) => WordResModel.fromJson(json: jsonWord)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWord(
      {required ResponseDataModel<WordResModel>? wordResModel}) async {
    if (wordResModel != null) {
      sharedPreferences.setString(
        cachedWord,
        json.encode(
          wordResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWordDetail(
      {required ResponseDataModel<WordModel>? wordModel}) async {
    if (wordModel != null) {
      sharedPreferences.setString(
        cachedWordDetail,
        json.encode(
          wordModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<WordModel>> getLastWordDetail() async {
    final jsonString = sharedPreferences.getString(cachedWordDetail);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<WordModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonWord) => WordModel.fromJson(json: jsonWord)));
    } else {
      throw CacheException();
    }
  }
}
