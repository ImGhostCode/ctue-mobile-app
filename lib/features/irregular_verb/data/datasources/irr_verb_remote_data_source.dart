import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_model.dart';
import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class IrrVerbRemoteDataSource {
  Future<ResponseDataModel<IrrVerbResModel>> getIrrVerbs(
      {required IrrVerbParams irrVerbParams});
  Future<ResponseDataModel<IrrVerbModel>> createIrrVerb(
      {required CreateIrrVerbParams createIrrVerbParams});
  Future<ResponseDataModel<IrrVerbModel>> updateIrrVerb(
      {required UpdateIrrVerbParams updateIrrVerbParams});
  Future<ResponseDataModel<void>> deleteIrrVerb(
      {required DeleteIrrVerbParams deleteIrrVerbParams});
}

class IrrVerbRemoteDataSourceImpl implements IrrVerbRemoteDataSource {
  final Dio dio;

  IrrVerbRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<IrrVerbResModel>> getIrrVerbs(
      {required IrrVerbParams irrVerbParams}) async {
    try {
      final response = await dio.get('/irregular-verbs/',
          queryParameters: {
            "page": irrVerbParams.page,
            "sort": irrVerbParams.sort,
            "key": irrVerbParams.key
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<IrrVerbResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => IrrVerbResModel.fromJson(json: json));
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
  Future<ResponseDataModel<IrrVerbModel>> createIrrVerb(
      {required CreateIrrVerbParams createIrrVerbParams}) async {
    try {
      final response = await dio.post('/irregular-verbs',
          data: {
            "v1": createIrrVerbParams.v1,
            "v2": createIrrVerbParams.v2,
            "v3": createIrrVerbParams.v3,
            "meaning": createIrrVerbParams.meaning,
          },
          options: Options(headers: {
            "authorization": "Bearer ${createIrrVerbParams.accessToken}"
          }));
      return ResponseDataModel<IrrVerbModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => IrrVerbModel.fromJson(json: json));
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
  Future<ResponseDataModel<IrrVerbModel>> updateIrrVerb(
      {required UpdateIrrVerbParams updateIrrVerbParams}) async {
    try {
      final response = await dio.patch(
          '/irregular-verbs/${updateIrrVerbParams.irrVerbId}',
          data: {
            "v1": updateIrrVerbParams.v1,
            "v2": updateIrrVerbParams.v2,
            "v3": updateIrrVerbParams.v3,
            "meaning": updateIrrVerbParams.meaning,
          },
          options: Options(headers: {
            "authorization": "Bearer ${updateIrrVerbParams.accessToken}"
          }));
      return ResponseDataModel<IrrVerbModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => IrrVerbModel.fromJson(json: json));
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
  Future<ResponseDataModel<void>> deleteIrrVerb(
      {required DeleteIrrVerbParams deleteIrrVerbParams}) async {
    try {
      final response = await dio.delete(
          '/irregular-verbs/${deleteIrrVerbParams.irrVerbId}',
          options: Options(headers: {
            "authorization": "Bearer ${deleteIrrVerbParams.accessToken}"
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
