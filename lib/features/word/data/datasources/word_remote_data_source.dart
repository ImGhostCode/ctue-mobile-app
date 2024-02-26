import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class WordRemoteDataSource {
  Future<ResponseDataModel<List<WordModel>>> getWords(
      {required GetWordParams getWordParams});
  Future<ResponseDataModel<WordModel>> getWordDetail(
      {required GetWordParams getWordParams});
}

class WordRemoteDataSourceImpl implements WordRemoteDataSource {
  final Dio dio;

  WordRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<List<WordModel>>> getWords(
      {required GetWordParams getWordParams}) async {
    try {
      final response = await dio.get('/word',
          queryParameters: {
            'topic': getWordParams.topic,
            "type": getWordParams.type,
            'page': getWordParams.page,
            'level': getWordParams.level,
            'specialization': getWordParams.specialization,
            'sort': getWordParams.sort,
            'key': getWordParams.key,
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<List<WordModel>>.fromJson(
        json: response.data,
        fromJsonD: (jsonWords) => jsonWords['results']
            ?.map<WordModel>((json) => WordModel.fromJson(json: json))
            .toList(),
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
  Future<ResponseDataModel<WordModel>> getWordDetail(
      {required GetWordParams getWordParams}) async {
    try {
      final response = await dio.get('/word/${getWordParams.id}',
          queryParameters: {},
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<WordModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => WordModel.fromJson(json: json));
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
