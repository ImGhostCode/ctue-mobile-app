import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/vocabulary_pack/data/models/voca_set_model.dart';
import 'package:ctue_app/features/vocabulary_pack/data/models/voca_set_response_model.dart';
import 'package:ctue_app/features/vocabulary_pack/data/models/voca_set_statis_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class VocaSetLocalDataSource {
  Future<void> cacheVocaSet(
      {required ResponseDataModel<List<VocaSetModel>>? vocaSetResModel});
  Future<ResponseDataModel<List<VocaSetModel>>> getLastVocaSet();

  Future<void> cachePublicVocaSet(
      {required ResponseDataModel<List<VocaSetModel>>? vocaSetResModel});
  Future<ResponseDataModel<List<VocaSetModel>>> getLastPublicVocaSet();

  Future<void> cacheVocaSetByAdmin(
      {required ResponseDataModel<VocabularySetResModel>? vocaSetResModel});
  Future<ResponseDataModel<VocabularySetResModel>> getLastVocaSetByAdmin();

  Future<void> cacheVocaSetDetail(
      {required ResponseDataModel<VocaSetModel>? vocaSetResModel});
  Future<ResponseDataModel<VocaSetModel>> getLastVocaSetDetail();

  Future<void> cacheVocaSetStatistics(
      {required ResponseDataModel<VocaSetStatisticsModel>?
          vocaSetStatisticsResModel});
  Future<ResponseDataModel<VocaSetStatisticsModel>> getLastVocaSetStatistics();
}

const cachedVocaSet = 'CACHED_USER_VOCA_SETS';
const cachedPublicVocaSets = 'CACHED_PUBLIC_VOCA_SETS';
const cachedVocaSetsByAdmin = 'CACHED_USER_VOCA_SETS_BY_ADMIN';
const cachedVocaSetDetail = 'CACHED_USER_VOCA_SET_DETAIL';
const cachedVocaSetStatistics = 'CACHED_VOCA_SET_STATISTICS';

class VocaSetLocalDataSourceImpl implements VocaSetLocalDataSource {
  final SharedPreferences sharedPreferences;

  VocaSetLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<List<VocaSetModel>>> getLastVocaSet() {
    final jsonString = sharedPreferences.getString(cachedVocaSet);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<VocaSetModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonVocaSet) => jsonVocaSet
              ?.map<VocaSetModel>((json) => VocaSetModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVocaSet(
      {required ResponseDataModel<List<VocaSetModel>>? vocaSetResModel}) async {
    if (vocaSetResModel != null) {
      sharedPreferences.setString(
        cachedVocaSet,
        json.encode(Map.from({
          "data": vocaSetResModel.data.map((e) => e.toJson()).toList(),
          "statusCode": vocaSetResModel.statusCode,
          "message": vocaSetResModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVocaSetStatistics(
      {required ResponseDataModel<VocaSetStatisticsModel>?
          vocaSetStatisticsResModel}) async {
    if (vocaSetStatisticsResModel != null) {
      sharedPreferences.setString(
        cachedVocaSetStatistics,
        json.encode(
          vocaSetStatisticsResModel.toJson(
            toJsonD: (jsonVocaSetStatistics) => jsonVocaSetStatistics.toJson(),
          ),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<VocaSetStatisticsModel>>
      getLastVocaSetStatistics() async {
    final jsonString = sharedPreferences.getString(cachedVocaSetStatistics);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<VocaSetStatisticsModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonVocaSetStatistics) =>
              VocaSetStatisticsModel.fromJson(json: jsonVocaSetStatistics)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVocaSetDetail(
      {required ResponseDataModel<VocaSetModel>? vocaSetResModel}) async {
    if (vocaSetResModel != null) {
      sharedPreferences.setString(
        cachedVocaSetDetail,
        json.encode(
          vocaSetResModel.toJson(
            toJsonD: (jsonVocaSet) => jsonVocaSet.toJson(),
          ),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<VocaSetModel>> getLastVocaSetDetail() async {
    final jsonString = sharedPreferences.getString(cachedVocaSetDetail);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<VocaSetModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonVocaSet) =>
              VocaSetModel.fromJson(json: jsonVocaSet)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVocaSetByAdmin(
      {required ResponseDataModel<VocabularySetResModel>?
          vocaSetResModel}) async {
    if (vocaSetResModel != null) {
      sharedPreferences.setString(
        cachedVocaSetsByAdmin,
        json.encode(
          vocaSetResModel.toJson(
            toJsonD: (jsonVocaSet) => jsonVocaSet.toJson(),
          ),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<VocabularySetResModel>>
      getLastVocaSetByAdmin() async {
    final jsonString = sharedPreferences.getString(cachedVocaSetsByAdmin);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<VocabularySetResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonVocaSet) =>
              VocabularySetResModel.fromJson(json: jsonVocaSet)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePublicVocaSet(
      {required ResponseDataModel<List<VocaSetModel>>? vocaSetResModel}) async {
    if (vocaSetResModel != null) {
      sharedPreferences.setString(
        cachedPublicVocaSets,
        json.encode(Map.from({
          "data": vocaSetResModel.data.map((e) => e.toJson()).toList(),
          "statusCode": vocaSetResModel.statusCode,
          "message": vocaSetResModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<List<VocaSetModel>>> getLastPublicVocaSet() async {
    final jsonString = sharedPreferences.getString(cachedPublicVocaSets);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<VocaSetModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonVocaSet) => jsonVocaSet
              ?.map<VocaSetModel>((json) => VocaSetModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }
}
