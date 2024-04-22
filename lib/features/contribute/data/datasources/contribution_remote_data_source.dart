import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/data/models/contri_response_model.dart';
import 'package:ctue_app/features/contribute/data/models/contribution_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class ContributionRemoteDataSource {
  Future<ResponseDataModel<ContributionModel>> createWordContribution(
      {required CreateWordConParams createWordConParams});
  Future<ResponseDataModel<ContributionModel>> createSenContribution(
      {required CreateSenConParams createSenConParams});
  Future<ResponseDataModel<ContributionResModel>> getAllCon(
      {required GetAllConParams getAllConParams});
  Future<ResponseDataModel<ContributionResModel>> getAllConByUser(
      {required GetAllConByUserParams getAllConByUserParams});
  Future<ResponseDataModel<void>> verifyContribution(
      {required VerifyConParams verifyConParams});
}

class ContributionRemoteDataSourceImpl implements ContributionRemoteDataSource {
  final Dio dio;

  ContributionRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<ContributionModel>> createWordContribution(
      {required CreateWordConParams createWordConParams}) async {
    try {
      final formData = FormData.fromMap({
        'type': createWordConParams.type,
        'content': {
          "topicId": createWordConParams.content.topicId.length > 1
              ? createWordConParams.content.topicId
              : [createWordConParams.content.topicId],
          "levelId": createWordConParams.content.levelId,
          "specializationId": createWordConParams.content.specializationId,
          "content": createWordConParams.content.content,
          "meanings": createWordConParams.content.meanings!
              .map((meaning) => {
                    'typeId': meaning.typeId,
                    'meaning': meaning.meaning,
                  })
              .toList(),
          "note": createWordConParams.content.note,
          "phonetic": createWordConParams.content.phonetic,
          "examples": createWordConParams.content.examples!.length > 1
              ? createWordConParams.content.examples
              : [createWordConParams.content.examples],
          "synonyms": createWordConParams.content.synonyms!.length > 1
              ? createWordConParams.content.synonyms
              : [createWordConParams.content.synonyms],
          "antonyms": createWordConParams.content.antonyms!.length > 1
              ? createWordConParams.content.antonyms
              : [createWordConParams.content.antonyms],
        },
        "pictures": createWordConParams.content.pictures!
            .map((e) => MultipartFile.fromFileSync(e.path, filename: e.name))
            .toList(),
      });

      final response = await dio.post('/contributions/word',
          data: formData,
          options: Options(headers: {
            "authorization": "Bearer ${createWordConParams.accessToken}"
          }));
      return ResponseDataModel<ContributionModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => ContributionModel.fromJson(json: json));
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
  Future<ResponseDataModel<ContributionModel>> createSenContribution(
      {required CreateSenConParams createSenConParams}) async {
    try {
      final response = await dio.post('/contributions/sentence',
          data: {
            'type': createSenConParams.type,
            'content': {
              "topicId": [createSenConParams.content.topicId],
              "content": createSenConParams.content.content,
              "typeId": createSenConParams.content.typeId,
              "meaning": createSenConParams.content.meaning,
              "note": createSenConParams.content.note
            },
          },
          options: Options(headers: {
            "authorization": "Bearer ${createSenConParams.accessToken}"
          }));
      return ResponseDataModel<ContributionModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => ContributionModel.fromJson(json: json));
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
  Future<ResponseDataModel<ContributionResModel>> getAllCon(
      {required GetAllConParams getAllConParams}) async {
    try {
      final response = await dio.get('/contributions/',
          queryParameters: {
            'type': getAllConParams.type,
            'status': getAllConParams.status,
          },
          options: Options(headers: {
            "authorization": "Bearer ${getAllConParams.accessToken}"
          }));
      return ResponseDataModel<ContributionResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => ContributionResModel.fromJson(json: json));
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
  Future<ResponseDataModel<ContributionResModel>> getAllConByUser(
      {required GetAllConByUserParams getAllConByUserParams}) async {
    try {
      final response = await dio.get(
          '/contributions/user/${getAllConByUserParams.userId}',
          queryParameters: {'page': getAllConByUserParams.page},
          options: Options(headers: {
            "authorization": "Bearer ${getAllConByUserParams.accessToken}"
          }));
      return ResponseDataModel<ContributionResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => ContributionResModel.fromJson(json: json));
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
  Future<ResponseDataModel<void>> verifyContribution(
      {required VerifyConParams verifyConParams}) async {
    try {
      final response = await dio.patch(
          '/contributions/verify/${verifyConParams.isWord ? 'word' : 'sentence'}/${verifyConParams.contributionId}',
          data: {
            'status': verifyConParams.status,
            'feedback': verifyConParams.feedback
          },
          options: Options(headers: {
            "authorization": "Bearer ${verifyConParams.accessToken}"
          }));
      return ResponseDataModel<void>.fromJson(
          json: response.data, fromJsonD: (json) => json);
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
