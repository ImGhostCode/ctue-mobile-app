import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/data/models/contri_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/irr_verb_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/sen_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/voca_set_stat_model.dart';
import 'package:ctue_app/features/statistics/data/models/word_stat_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/user_stat_model.dart';

abstract class StatisticsRemoteDataSource {
  Future<ResponseDataModel<UserStatisticsModel>> getUserStatistics(
      {required StatisticsParams statisticsParams});
  Future<ResponseDataModel<ContriStatisticsModel>> getContriStatistics(
      {required StatisticsParams statisticsParams});
  Future<ResponseDataModel<WordStatisticsModel>> getWordStatistics(
      {required StatisticsParams statisticsParams});
  Future<ResponseDataModel<SenStatisticsModel>> getSenStatistics(
      {required StatisticsParams statisticsParams});
  Future<ResponseDataModel<IrrVerbStatisticsModel>> getIrrVerbStatistics(
      {required StatisticsParams statisticsParams});
  Future<ResponseDataModel<VocaSetStatisticsModel>> getVocaSetStatistics(
      {required StatisticsParams statisticsParams});
}

class StatisticsRemoteDataSourceImpl implements StatisticsRemoteDataSource {
  final Dio dio;

  StatisticsRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<UserStatisticsModel>> getUserStatistics(
      {required StatisticsParams statisticsParams}) async {
    try {
      final response = await dio.get('/statistics/user',
          queryParameters: {
            'startDate': statisticsParams.startDate,
            "endDate": statisticsParams.endDate,
          },
          options: Options(headers: {
            "authorization": "Bearer ${statisticsParams.accessToken}"
          }));

      return ResponseDataModel<UserStatisticsModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => UserStatisticsModel.fromJson(json: json),
      );
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
  Future<ResponseDataModel<ContriStatisticsModel>> getContriStatistics(
      {required StatisticsParams statisticsParams}) async {
    try {
      final response = await dio.get('/statistics/contribution',
          queryParameters: {
            'startDate': statisticsParams.startDate,
            "endDate": statisticsParams.endDate,
          },
          options: Options(headers: {
            "authorization": "Bearer ${statisticsParams.accessToken}"
          }));

      return ResponseDataModel<ContriStatisticsModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => ContriStatisticsModel.fromJson(json: json),
      );
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
  Future<ResponseDataModel<WordStatisticsModel>> getWordStatistics(
      {required StatisticsParams statisticsParams}) async {
    try {
      final response = await dio.get('/statistics/word',
          queryParameters: {
            'startDate': statisticsParams.startDate,
            "endDate": statisticsParams.endDate,
          },
          options: Options(headers: {
            "authorization": "Bearer ${statisticsParams.accessToken}"
          }));

      return ResponseDataModel<WordStatisticsModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => WordStatisticsModel.fromJson(json: json),
      );
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
  Future<ResponseDataModel<IrrVerbStatisticsModel>> getIrrVerbStatistics(
      {required StatisticsParams statisticsParams}) async {
    try {
      final response = await dio.get('/statistics/irregular-verb',
          queryParameters: {
            'startDate': statisticsParams.startDate,
            "endDate": statisticsParams.endDate,
          },
          options: Options(headers: {
            "authorization": "Bearer ${statisticsParams.accessToken}"
          }));

      return ResponseDataModel<IrrVerbStatisticsModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => IrrVerbStatisticsModel.fromJson(json: json),
      );
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
  Future<ResponseDataModel<SenStatisticsModel>> getSenStatistics(
      {required StatisticsParams statisticsParams}) async {
    try {
      final response = await dio.get('/statistics/sentence',
          queryParameters: {
            'startDate': statisticsParams.startDate,
            "endDate": statisticsParams.endDate,
          },
          options: Options(headers: {
            "authorization": "Bearer ${statisticsParams.accessToken}"
          }));

      return ResponseDataModel<SenStatisticsModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => SenStatisticsModel.fromJson(json: json),
      );
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
  Future<ResponseDataModel<VocaSetStatisticsModel>> getVocaSetStatistics(
      {required StatisticsParams statisticsParams}) async {
    try {
      print("start date ${statisticsParams.startDate}");
      print("end date ${statisticsParams.endDate}");
      final response = await dio.get('/statistics/vocabulary-set',
          queryParameters: {
            'startDate': statisticsParams.startDate,
            "endDate": statisticsParams.endDate,
          },
          options: Options(headers: {
            "authorization": "Bearer ${statisticsParams.accessToken}"
          }));

      return ResponseDataModel<VocaSetStatisticsModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => VocaSetStatisticsModel.fromJson(json: json),
      );
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
