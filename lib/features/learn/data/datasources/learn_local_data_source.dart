import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/learn/data/models/learn_response_model.dart';
import 'package:ctue_app/features/learn/data/models/review_reminder_model.dart';
import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class LearnLocalDataSource {
  Future<void> cacheReviewReminder(
      {required ResponseDataModel<ReviewReminderModel?>? reviewReminderModel});
  Future<ResponseDataModel<ReviewReminderModel?>> getLastReviewReminder();

  Future<void> cacheUserLearnedWords(
      {required ResponseDataModel<List<UserLearnedWordModel>>?
          userLearnedWords});
  Future<ResponseDataModel<List<UserLearnedWordModel>>>
      getLastUserLearnedWords();

  Future<void> cacheLearningHistory(
      {required ResponseDataModel<LearnResModel>? learnResModel});
  Future<ResponseDataModel<LearnResModel>> getLastLearningHistory();
}

const cachedReviewReminder = 'CACHED_REVIEW_REMINDER';
const cachedVoices = 'CACHED_VOICES';
const cachedUserLearnedWords = 'CACHED_USER_LEARNED_WORDS';
const cachedLearningHistory = 'CACHED_LEARNING_HISTORY';
const cachedTextToLearn = 'CACHED_TEXT_TO_SPEECH';

class LearnLocalDataSourceImpl implements LearnLocalDataSource {
  final SharedPreferences sharedPreferences;

  LearnLocalDataSourceImpl({required this.sharedPreferences});

  // @override
  // Future<ResponseDataModel<PronuncStatisticModel>>
  //     getLastUserPronuncStatistics() {
  //   final jsonString = sharedPreferences.getString(cachedUPStatistics);

  //   if (jsonString != null) {
  //     return Future.value(
  //       ResponseDataModel<PronuncStatisticModel>.fromJson(
  //         json: json.decode(jsonString),
  //         fromJsonD: (jsonItems) =>
  //             PronuncStatisticModel.fromJson(json: jsonItems),
  //       ),
  //     );
  //   } else {
  //     throw CacheException();
  //   }
  // }

  // @override
  // Future<void> cacheReviewReminder(
  //     {required ResponseDataModel<PronuncStatisticModel>?
  //         reviewReminderModel}) async {
  //   if (reviewReminderModel != null) {
  //     sharedPreferences.setString(
  //         cachedReviewReminder,
  //         json.encode(reviewReminderModel.toJson(
  //             toJsonD: (jsonItems) => jsonItems.toJson())));
  //   } else {
  //     throw CacheException();
  //   }
  // }

  @override
  Future<ResponseDataModel<ReviewReminderModel?>> getLastReviewReminder() {
    final jsonString = sharedPreferences.getString(cachedReviewReminder);

    if (jsonString != null) {
      return Future.value(
        ResponseDataModel<ReviewReminderModel?>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonItems) => jsonItems != null
              ? ReviewReminderModel.fromJson(json: jsonItems)
              : null,
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheReviewReminder(
      {required ResponseDataModel<ReviewReminderModel?>?
          reviewReminderModel}) async {
    if (reviewReminderModel != null) {
      sharedPreferences.setString(
          cachedReviewReminder,
          json.encode(Map.from({
            "data": reviewReminderModel.data?.toJson(),
            "statusCode": reviewReminderModel.statusCode,
            "message": reviewReminderModel.message
          })));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserLearnedWords(
      {required ResponseDataModel<List<UserLearnedWordModel>>?
          userLearnedWords}) async {
    if (userLearnedWords != null) {
      sharedPreferences.setString(
          cachedUserLearnedWords,
          json.encode(Map.from({
            "data": userLearnedWords.data.map((e) => e.toJson()).toList(),
            "statusCode": userLearnedWords.statusCode,
            "message": userLearnedWords.message
          })));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<List<UserLearnedWordModel>>>
      getLastUserLearnedWords() async {
    final jsonString = sharedPreferences.getString(cachedUserLearnedWords);
    if (jsonString != null) {
      return Future.value(
          ResponseDataModel<List<UserLearnedWordModel>>.fromJson(
              json: json.decode(jsonString),
              fromJsonD: (jsonVocaSet) => jsonVocaSet
                  ?.map<UserLearnedWordModel>(
                      (json) => UserLearnedWordModel.fromJson(json: json))
                  .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLearningHistory(
      {required ResponseDataModel<LearnResModel>? learnResModel}) async {
    if (learnResModel != null) {
      sharedPreferences.setString(
        cachedLearningHistory,
        json.encode(Map.from({
          "data": learnResModel.data.toJson(),
          "statusCode": learnResModel.statusCode,
          "message": learnResModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<LearnResModel>> getLastLearningHistory() async {
    final jsonString = sharedPreferences.getString(cachedLearningHistory);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<LearnResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonWords) => LearnResModel.fromJson(json: jsonWords)));
    } else {
      throw CacheException();
    }
  }
}
