import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/features/sentence/data/models/sentence_model.dart';
import 'package:ctue_app/features/sentence/data/models/word_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class SentenceRemoteDataSource {
  Future<ResponseDataModel<SentenceResModel>> getSentences(
      {required GetSentenceParams getSentenceParams});
  Future<ResponseDataModel<SentenceModel>> getSentenceDetail(
      {required GetSentenceParams getSentenceParams});
  Future<ResponseDataModel<SentenceModel>> createSentence(
      {required CreateSentenceParams createSentenceParams});
  Future<ResponseDataModel<SentenceModel>> editSentence(
      {required EditSentenceParams editSentenceParams});
  Future<ResponseDataModel<void>> deleteSentence(
      {required DeleteSentenceParams deleteSentenceParams});
}

class SentenceRemoteDataSourceImpl implements SentenceRemoteDataSource {
  final Dio dio;

  SentenceRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<SentenceResModel>> getSentences(
      {required GetSentenceParams getSentenceParams}) async {
    try {
      final response = await dio.get('/sentences',
          queryParameters: {
            'topic': getSentenceParams.topics!.length > 1
                ? getSentenceParams.topics
                : [getSentenceParams.topics],
            "type": getSentenceParams.type,
            'page': getSentenceParams.page,
            'sort': getSentenceParams.sort,
            'key': getSentenceParams.key,
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<SentenceResModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => SentenceResModel.fromJson(json: json),
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
  Future<ResponseDataModel<SentenceModel>> getSentenceDetail(
      {required GetSentenceParams getSentenceParams}) async {
    try {
      final response = await dio.get('/sentences/${getSentenceParams.id}',
          queryParameters: {},
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<SentenceModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => SentenceModel.fromJson(json: json));
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
  Future<ResponseDataModel<SentenceModel>> createSentence(
      {required CreateSentenceParams createSentenceParams}) async {
    try {
      final response = await dio.post('/sentences',
          data: {
            "topicId": createSentenceParams.topicId.length > 1
                ? createSentenceParams.topicId
                : [createSentenceParams.topicId],
            "content": createSentenceParams.content,
            "typeId": createSentenceParams.typeId,
            "meaning": createSentenceParams.meaning,
            "note": createSentenceParams.note,
          },
          options: Options(headers: {
            "authorization": "Bearer ${createSentenceParams.accessToken}"
          }));
      return ResponseDataModel<SentenceModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => SentenceModel.fromJson(json: json));
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
  Future<ResponseDataModel<SentenceModel>> editSentence(
      {required EditSentenceParams editSentenceParams}) async {
    try {
      final response = await dio.patch(
          '/sentences/${editSentenceParams.sentenceId}',
          data: {
            "topicId": editSentenceParams.topicId.length > 1
                ? editSentenceParams.topicId
                : [editSentenceParams.topicId],
            "typeId": editSentenceParams.typeId,
            "content": editSentenceParams.content,
            "meaning": editSentenceParams.meaning,
            "note": editSentenceParams.note,
          },
          options: Options(headers: {
            "authorization": "Bearer ${editSentenceParams.accessToken}"
          }));
      return ResponseDataModel<SentenceModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => SentenceModel.fromJson(json: json));
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
  Future<ResponseDataModel<void>> deleteSentence(
      {required DeleteSentenceParams deleteSentenceParams}) async {
    try {
      final response = await dio.delete(
          '/sentences/${deleteSentenceParams.sentenceId}',
          options: Options(headers: {
            "authorization": "Bearer ${deleteSentenceParams.accessToken}"
          }));
      return ResponseDataModel<void>.fromJson(
          json: response.data, fromJsonD: (json) {});
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(
            statusCode: 500, errorMessage: 'Can\'t connect server');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response?.data['message'] ?? 'Unknown server error');
      }
    }
  }
}
