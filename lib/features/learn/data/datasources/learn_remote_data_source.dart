import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/data/models/learn_response_model.dart';
import 'package:ctue_app/features/learn/data/models/review_reminder_model.dart';
import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class LearnRemoteDataSource {
  Future<ResponseDataModel<List<UserLearnedWordModel>>> saveLearnedResult(
      {required SaveLearnedResultParams saveLearnedResultParams});
  Future<ResponseDataModel<ReviewReminderModel>> creReviewReminder(
      {required CreReviewReminderParams creReviewReminderParams});
  Future<ResponseDataModel<ReviewReminderModel?>> getUpcomingReminder(
      {required GetUpcomingReminderParams getUpcomingReminderParams});
  Future<ResponseDataModel<List<UserLearnedWordModel>>> getUserLearnedWords(
      {required GetUserLearnedWordParams getUserLearnedWordParams});
  Future<ResponseDataModel<LearnResModel>> getLearningHistory(
      {required GetLearningHistoryParams getLearningHistoryParams});
}

class LearnRemoteDataSourceImpl implements LearnRemoteDataSource {
  final Dio dio;

  LearnRemoteDataSourceImpl({required this.dio});

  // @override
  // Future<ResponseDataModel<VocaSetStatisticsModel>> getVocaSetStatistics(
  //     {required GetVocaSetStatisParams getVocaSetStatisParams}) async {
  //   try {
  //     final response = await dio.post('/learn/learned-result',
  //     data: {
  //       'wordIds' :
  //     },
  //         // queryParameters: {"setId": getVocaSetStatisParams.id},
  //         options: Options(headers: {
  //           "authorization": "Bearer ${getVocaSetStatisParams.accessToken}"
  //         }));
  //     return ResponseDataModel<VocaSetStatisticsModel>.fromJson(
  //         json: response.data,
  //         fromJsonD: (json) => VocaSetStatisticsModel.fromJson(json: json));
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionError ||
  //         e.type == DioExceptionType.cancel) {
  //       throw ServerException(
  //           statusCode: 400, errorMessage: 'Connection Refused');
  //     } else {
  //       throw ServerException(
  //           statusCode: e.response!.statusCode!,
  //           errorMessage:
  //               e.response!.data['message'] ?? 'Unknown server error');
  //     }
  //   }
  // }

  @override
  Future<ResponseDataModel<List<UserLearnedWordModel>>> saveLearnedResult(
      {required SaveLearnedResultParams saveLearnedResultParams}) async {
    try {
      final response = await dio.post('/learn/learned-result',
          data: {
            'wordIds': saveLearnedResultParams.wordIds,
            'vocabularyPackId': saveLearnedResultParams.vocabularySetId,
            if (saveLearnedResultParams.reviewReminderId != null)
              'reviewReminderId': saveLearnedResultParams.reviewReminderId,
            'memoryLevels': saveLearnedResultParams.memoryLevels,
          },
          // queryParameters: {"setId": getVocaSetStatisParams.id},
          options: Options(headers: {
            "authorization": "Bearer ${saveLearnedResultParams.accessToken}"
          }));
      return ResponseDataModel<List<UserLearnedWordModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json['results']
              .map<UserLearnedWordModel>(
                  (e) => UserLearnedWordModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<ReviewReminderModel>> creReviewReminder(
      {required CreReviewReminderParams creReviewReminderParams}) async {
    try {
      final response = await dio.post('/learn/review-reminder',
          data: {
            'vocabularyPackId': creReviewReminderParams.vocabularySetId,
            'data': creReviewReminderParams.data,
          },
          // queryParameters: {"setId": getVocaSetStatisParams.id},
          options: Options(headers: {
            "authorization": "Bearer ${creReviewReminderParams.accessToken}"
          }));
      return ResponseDataModel<ReviewReminderModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => ReviewReminderModel.fromJson(json: json[0]));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<ReviewReminderModel?>> getUpcomingReminder(
      {required GetUpcomingReminderParams getUpcomingReminderParams}) async {
    try {
      final response = await dio.get('/learn/upcoming-reminder',
          queryParameters: {
            if (getUpcomingReminderParams.vocabularySetId != null)
              "packId": getUpcomingReminderParams.vocabularySetId
          },
          options: Options(headers: {
            "authorization": "Bearer ${getUpcomingReminderParams.accessToken}"
          }));
      return ResponseDataModel<ReviewReminderModel?>.fromJson(
          json: response.data,
          fromJsonD: (json) =>
              json != null ? ReviewReminderModel.fromJson(json: json) : null);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<List<UserLearnedWordModel>>> getUserLearnedWords(
      {required GetUserLearnedWordParams getUserLearnedWordParams}) async {
    try {
      final response = await dio.get(
          '/learn/${getUserLearnedWordParams.setId}/user/learned',

          // queryParameters: {"setId": getVocaSetStatisParams.id},
          options: Options(headers: {
            "authorization": "Bearer ${getUserLearnedWordParams.accessToken}"
          }));
      return ResponseDataModel<List<UserLearnedWordModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<UserLearnedWordModel>(
                  (word) => UserLearnedWordModel.fromJson(json: word))
              .toList());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<LearnResModel>> getLearningHistory(
      {required GetLearningHistoryParams getLearningHistoryParams}) async {
    try {
      final response = await dio.get(
          '/learn/history/${getLearningHistoryParams.userId}',
          queryParameters: {
            "page": getLearningHistoryParams.page,
            if (getLearningHistoryParams.level != null)
              "level": getLearningHistoryParams.level,
            "sort": getLearningHistoryParams.sort
          },
          options: Options(headers: {
            "authorization": "Bearer ${getLearningHistoryParams.accessToken}"
          }));
      return ResponseDataModel<LearnResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => LearnResModel.fromJson(json: json));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }
}
