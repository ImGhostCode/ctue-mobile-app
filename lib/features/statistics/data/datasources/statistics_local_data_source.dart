import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/statistics/data/models/contri_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/irr_verb_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/sen_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/word_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/voca_set_stat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/user_stat_model.dart';

abstract class StatisticsLocalDataSource {
  Future<void> cacheUserStatistics(
      {required ResponseDataModel<UserStatisticsModel>? userStatisticsModel});
  Future<ResponseDataModel<UserStatisticsModel>> getLastUserStatistics();
  Future<void> cacheContributionStatistics(
      {required ResponseDataModel<ContriStatisticsModel>?
          contriStatisticsModel});
  Future<ResponseDataModel<ContriStatisticsModel>>
      getLastContributionStatistics();
  Future<void> cacheWordStatistics(
      {required ResponseDataModel<WordStatisticsModel>? wordStatisticsModel});
  Future<ResponseDataModel<WordStatisticsModel>> getLastWordStatistics();
  Future<void> cacheSentenceStatistics(
      {required ResponseDataModel<SenStatisticsModel>? senStatisticsModel});
  Future<ResponseDataModel<SenStatisticsModel>> getLastSentenceStatistics();
  Future<void> cacheIrrVerbStatistics(
      {required ResponseDataModel<IrrVerbStatisticsModel>?
          irrVerbStatisticsModel});
  Future<ResponseDataModel<IrrVerbStatisticsModel>> getLastIrrVerbStatistics();
  Future<void> cacheVocaSetStatistics(
      {required ResponseDataModel<VocaSetStatisticsModel>?
          vocaSetStatisticsModel});
  Future<ResponseDataModel<VocaSetStatisticsModel>> getLastVocaSetStatistics();
}

const cachedUserStatistics = 'CACHED_USER_STATISTICS';
const cachedConStatistics = 'CACHED_CONTRIBUTION_STATISTICS';
const cachedWordStatistics = 'CACHED_WORD_STATISTICS';
const cachedSetenceStatistics = 'CACHED_SENTENCE_STATISTICS';
const cachedIrrVerbStatistics = 'CACHED_IRR_VERB_STATISTICS';
const cachedVocaSetStatistics = 'CACHED_VOCA_SET_STATISTICS';

class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  final SharedPreferences sharedPreferences;

  StatisticsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<UserStatisticsModel>> getLastUserStatistics() {
    final jsonString = sharedPreferences.getString(cachedUserStatistics);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<UserStatisticsModel>.fromJson(
          fromJsonD: (json) => UserStatisticsModel.fromJson(json: json),
          json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserStatistics(
      {required ResponseDataModel<UserStatisticsModel>?
          userStatisticsModel}) async {
    if (userStatisticsModel != null) {
      sharedPreferences.setString(
        cachedUserStatistics,
        json.encode(
          userStatisticsModel.toJson(toJsonD: (model) => model.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheContributionStatistics(
      {required ResponseDataModel<ContriStatisticsModel>?
          contriStatisticsModel}) async {
    if (contriStatisticsModel != null) {
      sharedPreferences.setString(
        cachedConStatistics,
        json.encode(
          contriStatisticsModel.toJson(toJsonD: (model) => model.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheIrrVerbStatistics(
      {required ResponseDataModel<IrrVerbStatisticsModel>?
          irrVerbStatisticsModel}) async {
    if (irrVerbStatisticsModel != null) {
      sharedPreferences.setString(
        cachedIrrVerbStatistics,
        json.encode(
          irrVerbStatisticsModel.toJson(toJsonD: (model) => model.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSentenceStatistics(
      {required ResponseDataModel<SenStatisticsModel>?
          senStatisticsModel}) async {
    if (senStatisticsModel != null) {
      sharedPreferences.setString(
        cachedSetenceStatistics,
        json.encode(
          senStatisticsModel.toJson(toJsonD: (model) => model.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVocaSetStatistics(
      {required ResponseDataModel<VocaSetStatisticsModel>?
          vocaSetStatisticsModel}) async {
    if (vocaSetStatisticsModel != null) {
      sharedPreferences.setString(
        cachedVocaSetStatistics,
        json.encode(
          vocaSetStatisticsModel.toJson(toJsonD: (model) => model.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWordStatistics(
      {required ResponseDataModel<WordStatisticsModel>?
          wordStatisticsModel}) async {
    if (wordStatisticsModel != null) {
      sharedPreferences.setString(
        cachedWordStatistics,
        json.encode(
          wordStatisticsModel.toJson(toJsonD: (model) => model.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<ContriStatisticsModel>>
      getLastContributionStatistics() async {
    final jsonString = sharedPreferences.getString(cachedConStatistics);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<ContriStatisticsModel>.fromJson(
          fromJsonD: (json) => ContriStatisticsModel.fromJson(json: json),
          json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<IrrVerbStatisticsModel>>
      getLastIrrVerbStatistics() async {
    final jsonString = sharedPreferences.getString(cachedIrrVerbStatistics);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<IrrVerbStatisticsModel>.fromJson(
          fromJsonD: (json) => IrrVerbStatisticsModel.fromJson(json: json),
          json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<SenStatisticsModel>>
      getLastSentenceStatistics() async {
    final jsonString = sharedPreferences.getString(cachedSetenceStatistics);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<SenStatisticsModel>.fromJson(
          fromJsonD: (json) => SenStatisticsModel.fromJson(json: json),
          json: json.decode(jsonString)));
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
          fromJsonD: (json) => VocaSetStatisticsModel.fromJson(json: json),
          json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<WordStatisticsModel>> getLastWordStatistics() async {
    final jsonString = sharedPreferences.getString(cachedWordStatistics);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<WordStatisticsModel>.fromJson(
          fromJsonD: (json) => WordStatisticsModel.fromJson(json: json),
          json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
