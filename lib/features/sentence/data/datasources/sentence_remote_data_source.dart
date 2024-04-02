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
}

class SentenceRemoteDataSourceImpl implements SentenceRemoteDataSource {
  final Dio dio;

  SentenceRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<SentenceResModel>> getSentences(
      {required GetSentenceParams getSentenceParams}) async {
    try {
      final response = await dio.get('/sentence',
          queryParameters: {
            'topic': getSentenceParams.topics,
            "type": getSentenceParams.type,
            'page': getSentenceParams.page,
            'sort': getSentenceParams.sort
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      // ResponseDataModel<List<SentenceModel>> listSentenceModel =
      //     response.data['data'].map((topic) => {
      //           topic.fromJson(
      //               json: response.data,
      //               fromJsonD: (json) => SentenceModel.fromJson(json: json)).toList();
      // });

      // return listSentenceModel;

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
      final response = await dio.get('/sentence/${getSentenceParams.id}',
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
}
