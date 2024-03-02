import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/data/models/contribution_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class ContributionRemoteDataSource {
  Future<ResponseDataModel<ContributionModel>> createWordContribution(
      {required CreateWordConParams createWordConParams});
  Future<ResponseDataModel<ContributionModel>> createSenContribution(
      {required CreateSenConParams createSenConParams});
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
          "topicId": [createWordConParams.content.topicId],
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
          "examples": createWordConParams.content.examples,
          "synonyms": createWordConParams.content.synonyms,
          "antonyms": createWordConParams.content.antonyms,
        },
        "pictures": createWordConParams.content.pictures!
            .map((e) => MultipartFile.fromFileSync(e.path, filename: e.name))
            .toList(),
      });

      final response = await dio.post('/contribution/word',
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
      final response = await dio.post('/contribution/sentence',
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
}
