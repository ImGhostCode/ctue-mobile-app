import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/data/models/review_reminder_model.dart';
import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class LearnRemoteDataSource {
  Future<ResponseDataModel<List<UserLearnedWordModel>>> saveLearnedResult(
      {required SaveLearnedResultParams saveLearnedResultParams});
  Future<ResponseDataModel<ReviewReminderModel>> creReviewReminder(
      {required CreReviewReminderParams creReviewReminderParams});
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
            'vocabularySetId': saveLearnedResultParams.vocabularySetId,
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
            'vocabularySetId': creReviewReminderParams.vocabularySetId,
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
}
