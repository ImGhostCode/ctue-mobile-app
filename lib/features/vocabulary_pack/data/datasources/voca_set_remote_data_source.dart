import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_pack/data/models/voca_set_model.dart';
import 'package:ctue_app/features/vocabulary_pack/data/models/voca_set_response_model.dart';
import 'package:ctue_app/features/vocabulary_pack/data/models/voca_set_statis_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class VocaSetRemoteDataSource {
  Future<ResponseDataModel<VocaSetModel>> creVocaSet(
      {required CreVocaSetParams creVocaSetParams});
  Future<ResponseDataModel<List<VocaSetModel>>> getUserVocaSets(
      {required GetVocaSetParams getVocaSetParams});
  Future<ResponseDataModel<List<VocaSetModel>>> getVocaSets(
      {required GetVocaSetParams getVocaSetParams});
  Future<ResponseDataModel<VocabularySetResModel>> getVocaSetsByAdmin(
      {required GetVocaSetParams getVocaSetParams});
  Future<ResponseDataModel<VocaSetModel>> getVocaSetDetail(
      {required GetVocaSetParams getVocaSetParams});
  Future<ResponseDataModel<VocaSetModel>> updateVocaSet(
      {required UpdateVocaSetParams updateVocaSetParams});
  Future<ResponseDataModel<VocaSetModel>> removeVocaSet(
      {required RemoveVocaSetParams removeVocaSetParams});
  Future<ResponseDataModel<VocaSetModel>> downloadVocaSet(
      {required DownloadVocaSetParams downloadVocaSetParams});
  Future<ResponseDataModel<VocaSetStatisticsModel>> getVocaSetStatistics(
      {required GetVocaSetStatisParams getVocaSetStatisParams});
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
        "words": creVocaSetParams.words.length > 1
            ? creVocaSetParams.words
            : [creVocaSetParams.words],
        "picture": creVocaSetParams.picture != null
            ? MultipartFile.fromFileSync(creVocaSetParams.picture!.path,
                filename: creVocaSetParams.picture!.name)
            : null
      });

      final response = await dio.post('/vocabulary-packs',
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
      final response = await dio.get('/vocabulary-packs/user',
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
      final response = await dio.get('/vocabulary-packs/${getVocaSetParams.id}',
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
      final response = await dio.get('/vocabulary-packs',
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
          '/vocabulary-packs${removeVocaSetParams.isDownloaded ? '/user' : ''}/${removeVocaSetParams.id}',
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
      final formData = FormData.fromMap({
        "title": updateVocaSetParams.title,
        if (updateVocaSetParams.topicId != null)
          "topicId": updateVocaSetParams.topicId,
        if (updateVocaSetParams.specId != null)
          "specId": updateVocaSetParams.specId,
        if (updateVocaSetParams.isPublic != null)
          "isPublic": updateVocaSetParams.isPublic,
        if (updateVocaSetParams.oldPicture != null)
          'oldPicture': updateVocaSetParams.oldPicture,
        if (updateVocaSetParams.words != null)
          'words': updateVocaSetParams.words!.length > 1
              ? updateVocaSetParams.words
              : [updateVocaSetParams.words],
        if (updateVocaSetParams.oldWords != null)
          'oldWords': updateVocaSetParams.oldWords!.length > 1
              ? updateVocaSetParams.oldWords
              : [updateVocaSetParams.oldWords],
        if (updateVocaSetParams.picture != null)
          "picture": MultipartFile.fromFileSync(
              updateVocaSetParams.picture!.path,
              filename: updateVocaSetParams.picture!.name)
      });

      final response = await dio.patch(
          '/vocabulary-packs/${updateVocaSetParams.id}',
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
          '/vocabulary-packs/download/${downloadVocaSetParams.id}',
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

  @override
  Future<ResponseDataModel<VocaSetStatisticsModel>> getVocaSetStatistics(
      {required GetVocaSetStatisParams getVocaSetStatisParams}) async {
    try {
      final queryParameters = <String, dynamic>{};

      if (getVocaSetStatisParams.id != null) {
        queryParameters['setId'] = getVocaSetStatisParams.id;
      }
      final response = await dio.get('/learn/statistics',
          queryParameters: queryParameters,
          options: Options(headers: {
            "authorization": "Bearer ${getVocaSetStatisParams.accessToken}"
          }));
      return ResponseDataModel<VocaSetStatisticsModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => VocaSetStatisticsModel.fromJson(json: json));
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
  Future<ResponseDataModel<VocabularySetResModel>> getVocaSetsByAdmin(
      {required GetVocaSetParams getVocaSetParams}) async {
    try {
      final response = await dio.get('/vocabulary-packs/admin',
          queryParameters: {
            "spec": getVocaSetParams.specId,
            "topic": getVocaSetParams.topicId,
            "key": getVocaSetParams.key,
            'page': getVocaSetParams.page
          },
          options: Options(headers: {
            "authorization": "Bearer ${getVocaSetParams.accessToken}"
          }));
      return ResponseDataModel<VocabularySetResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => VocabularySetResModel.fromJson(json: json));
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
