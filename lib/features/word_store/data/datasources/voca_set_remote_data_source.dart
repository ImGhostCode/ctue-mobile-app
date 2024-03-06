import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/word_store/data/models/voca_set_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class VocaSetRemoteDataSource {
  Future<ResponseDataModel<VocaSetModel>> creVocaSet(
      {required CreVocaSetParams creVocaSetParams});
  Future<ResponseDataModel<List<VocaSetModel>>> getUserVocaSets(
      {required GetVocaSetParams getVocaSetParams});
  Future<ResponseDataModel<List<VocaSetModel>>> getVocaSets(
      {required GetVocaSetParams getVocaSetParams});
  Future<ResponseDataModel<VocaSetModel>> getVocaSetDetail(
      {required GetVocaSetParams getVocaSetParams});
}

class VocaSetRemoteDataSourceImpl implements VocaSetRemoteDataSource {
  final Dio dio;

  VocaSetRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<VocaSetModel>> creVocaSet(
      {required CreVocaSetParams creVocaSetParams}) async {
    try {
      final formData = FormData.fromMap({
        "title": creVocaSetParams.title,
        "topicId": creVocaSetParams.topicId,
        "specId": creVocaSetParams.specId,
        "words": creVocaSetParams.words,
        "picture": creVocaSetParams.picture != null
            ? MultipartFile.fromFileSync(creVocaSetParams.picture!.path,
                filename: creVocaSetParams.picture!.name)
            : null
      });

      final response = await dio.post('/vocabulary-set',
          data: formData,
          options: Options(headers: {
            "authorization": "Bearer ${creVocaSetParams.accessToken}"
          }));
      return ResponseDataModel<VocaSetModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => VocaSetModel.fromJson(json: json));
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
  Future<ResponseDataModel<List<VocaSetModel>>> getUserVocaSets(
      {required GetVocaSetParams getVocaSetParams}) async {
    try {
      final response = await dio.get('/vocabulary-set/user',
          queryParameters: {},
          options: Options(headers: {
            "authorization": "Bearer ${getVocaSetParams.accessToken}"
          }));
      return ResponseDataModel<List<VocaSetModel>>.fromJson(
          json: response.data,
          fromJsonD: (jsonWords) => jsonWords['results']
              ?.map<VocaSetModel>((json) => VocaSetModel.fromJson(json: json))
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
  Future<ResponseDataModel<VocaSetModel>> getVocaSetDetail(
      {required GetVocaSetParams getVocaSetParams}) async {
    try {
      final response = await dio.get('/vocabulary-set/${getVocaSetParams.id}',
          queryParameters: {},
          options: Options(headers: {
            "authorization": "Bearer ${getVocaSetParams.accessToken}"
          }));
      return ResponseDataModel<VocaSetModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => VocaSetModel.fromJson(json: json));
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
  Future<ResponseDataModel<List<VocaSetModel>>> getVocaSets(
      {required GetVocaSetParams getVocaSetParams}) async {
    try {
      final response = await dio.get('/vocabulary-set',
          queryParameters: {
            "spec": getVocaSetParams.specId,
            "topic": getVocaSetParams.topicId,
            "key": getVocaSetParams.key,
          },
          options: Options(headers: {
            "authorization": "Bearer ${getVocaSetParams.accessToken}"
          }));
      return ResponseDataModel<List<VocaSetModel>>.fromJson(
          json: response.data,
          fromJsonD: (jsonWords) => jsonWords['results']
              ?.map<VocaSetModel>((json) => VocaSetModel.fromJson(json: json))
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
}
