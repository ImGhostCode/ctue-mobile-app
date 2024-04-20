import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/sentence/data/models/sentence_model.dart';
import 'package:ctue_app/features/sentence/data/models/word_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class SentenceLocalDataSource {
  Future<void> cacheSentence(
      {required ResponseDataModel<SentenceResModel>? sentenceResModel});
  Future<ResponseDataModel<SentenceResModel>> getLastSentence();
  Future<void> cacheSentenceDetail(
      {required ResponseDataModel<SentenceModel>? sentenceModel});
  Future<ResponseDataModel<SentenceModel>> getLastSentenceDetail();
}

const cachedSentence = 'CACHED_SENTENCE';
const cachedSentenceDetail = 'CACHED_SENTENCE_DETAIL';

class SentenceLocalDataSourceImpl implements SentenceLocalDataSource {
  final SharedPreferences sharedPreferences;

  SentenceLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<SentenceResModel>> getLastSentence() {
    final jsonString = sharedPreferences.getString(cachedSentence);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<SentenceResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonSentence) =>
              SentenceResModel.fromJson(json: jsonSentence)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSentence(
      {required ResponseDataModel<SentenceResModel>? sentenceResModel}) async {
    if (sentenceResModel != null) {
      sharedPreferences.setString(
        cachedSentence,
        json.encode(
          sentenceResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSentenceDetail(
      {required ResponseDataModel<SentenceModel>? sentenceModel}) async {
    if (sentenceModel != null) {
      sharedPreferences.setString(
        cachedSentenceDetail,
        json.encode(
          sentenceModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<SentenceModel>> getLastSentenceDetail() async {
    final jsonString = sharedPreferences.getString(cachedSentenceDetail);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<SentenceModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonSentence) =>
              SentenceModel.fromJson(json: jsonSentence)));
    } else {
      throw CacheException();
    }
  }
}
