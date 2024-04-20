import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/speech/data/models/pronuc_statistics_model.dart';
import 'package:ctue_app/features/speech/data/models/voice_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class SpeechLocalDataSource {
  Future<void> cacheUserPronuncStatistics(
      {required ResponseDataModel<PronuncStatisticModel>?
          pronuncStatisticModel});
  Future<ResponseDataModel<PronuncStatisticModel>>
      getLastUserPronuncStatistics();

  Future<void> cacheVoices(
      {required ResponseDataModel<List<VoiceModel>>? pronuncStatisticModel});
  Future<ResponseDataModel<List<VoiceModel>>> getLastVoices();

  Future<void> cacheTextToSpeech(
      {required ResponseDataModel<List<int>>? audioData});
  Future<ResponseDataModel<List<int>>> getLastTextToSpeech();
}

const cachedUPStatistics = 'CACHED_USER_PRONUNC_STATISTICS';
const cachedVoices = 'CACHED_VOICES';
const cachedTextToSpeech = 'CACHED_TEXT_TO_SPEECH';

class SpeechLocalDataSourceImpl implements SpeechLocalDataSource {
  final SharedPreferences sharedPreferences;

  SpeechLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<PronuncStatisticModel>>
      getLastUserPronuncStatistics() {
    final jsonString = sharedPreferences.getString(cachedUPStatistics);

    if (jsonString != null) {
      return Future.value(
        ResponseDataModel<PronuncStatisticModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonItems) =>
              PronuncStatisticModel.fromJson(json: jsonItems),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserPronuncStatistics(
      {required ResponseDataModel<PronuncStatisticModel>?
          pronuncStatisticModel}) async {
    if (pronuncStatisticModel != null) {
      sharedPreferences.setString(
          cachedUPStatistics,
          json.encode(pronuncStatisticModel.toJson(
              toJsonD: (jsonItems) => jsonItems.toJson())));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<List<VoiceModel>>> getLastVoices() {
    final jsonString = sharedPreferences.getString(cachedVoices);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<VoiceModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonVocaSet) => jsonVocaSet
              ?.map<VoiceModel>((json) => VoiceModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVoices(
      {required ResponseDataModel<List<VoiceModel>>?
          pronuncStatisticModel}) async {
    if (pronuncStatisticModel != null) {
      sharedPreferences.setString(
        cachedVoices,
        json.encode(Map.from({
          "data": pronuncStatisticModel.data.map((e) => e.toJson()).toList(),
          "statusCode": pronuncStatisticModel.statusCode,
          "message": pronuncStatisticModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTextToSpeech(
      {required ResponseDataModel<List<int>>? audioData}) async {
    if (audioData != null) {
      sharedPreferences.setString(
        cachedTextToSpeech,
        json.encode(Map.from({
          "data": audioData.data,
          "statusCode": audioData.statusCode,
          "message": audioData.message
        })),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<List<int>>> getLastTextToSpeech() {
    final jsonString = sharedPreferences.getString(cachedTextToSpeech);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<int>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonData) => List<int>.from(jsonData)));
    } else {
      throw CacheException();
    }
  }
}
