import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_model.dart';
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
  Future<ResponseDataModel<VocaSetModel>> updateVocaSet(
      {required UpdateVocaSetParams updateVocaSetParams});
  Future<ResponseDataModel<VocaSetModel>> removeVocaSet(
      {required RemoveVocaSetParams removeVocaSetParams});
  Future<ResponseDataModel<VocaSetModel>> downloadVocaSet(
      {required DownloadVocaSetParams downloadVocaSetParams});
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

  @override
  Future<ResponseDataModel<VocaSetModel>> removeVocaSet(
      {required RemoveVocaSetParams removeVocaSetParams}) async {
    try {
      final response = await dio.delete(
          '/vocabulary-set${removeVocaSetParams.isDownloaded ? '/user' : ''}/${removeVocaSetParams.id}',
          queryParameters: {},
          options: Options(headers: {
            "authorization": "Bearer ${removeVocaSetParams.accessToken}"
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
  Future<ResponseDataModel<VocaSetModel>> updateVocaSet(
      {required UpdateVocaSetParams updateVocaSetParams}) async {
    try {
      final dataUpdate = {
        "title": updateVocaSetParams.title,
        "topicId": updateVocaSetParams.topicId,
        "specId": updateVocaSetParams.specId,
        "oldPicture": updateVocaSetParams.oldPicture,
        "picture": updateVocaSetParams.picture != null
            ? MultipartFile.fromFileSync(updateVocaSetParams.picture!.path,
                filename: updateVocaSetParams.picture!.name)
            : null
      };

      if (updateVocaSetParams.words != null) {
        dataUpdate['words'] = updateVocaSetParams.words;
      }

      final formData = FormData.fromMap({
        "title": updateVocaSetParams.title,
        "topicId": updateVocaSetParams.topicId,
        "specId": updateVocaSetParams.specId,
        "isPublic": updateVocaSetParams.isPublic,
        "oldPicture": updateVocaSetParams.oldPicture,
        "picture": updateVocaSetParams.picture != null
            ? MultipartFile.fromFileSync(updateVocaSetParams.picture!.path,
                filename: updateVocaSetParams.picture!.name)
            : null
      });

      // if (updateVocaSetParams.words != null) {
      //   formData.fields.add(MapEntry('words', updateVocaSetParams.words));
      // }

      final response = await dio.patch(
          '/vocabulary-set/${updateVocaSetParams.id}',
          data: formData,
          options: Options(headers: {
            "authorization": "Bearer ${updateVocaSetParams.accessToken}"
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
  Future<ResponseDataModel<VocaSetModel>> downloadVocaSet(
      {required DownloadVocaSetParams downloadVocaSetParams}) async {
    try {
      final response = await dio.patch(
          '/vocabulary-set/download/${downloadVocaSetParams.id}',
          queryParameters: {},
          options: Options(headers: {
            "authorization": "Bearer ${downloadVocaSetParams.accessToken}"
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
}
