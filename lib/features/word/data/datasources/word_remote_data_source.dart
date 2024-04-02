import 'dart:io';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/data/models/object_model.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:ctue_app/features/word/data/models/word_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class WordRemoteDataSource {
  Future<ResponseDataModel<WordResModel>> getWords(
      {required GetWordParams getWordParams});
  Future<ResponseDataModel<WordModel>> getWordDetail(
      {required GetWordParams getWordParams});
  Future<ResponseDataModel<List<WordModel>>> lookUpDictionary(
      {required LookUpDictionaryParams lookUpDictionaryParams});
  Future<ResponseDataModel<List<ObjectModel>>> lookUpByImage(
      {required LookUpByImageParams lookUpByImageParams});
}

class WordRemoteDataSourceImpl implements WordRemoteDataSource {
  final Dio dio;

  WordRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<WordResModel>> getWords(
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

      return ResponseDataModel<WordResModel>.fromJson(
        json: response.data,
        fromJsonD: (json) => WordResModel.fromJson(json: json),
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
      final response = await dio.get('/word/id/${getWordParams.id}',
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

  @override
  Future<ResponseDataModel<List<WordModel>>> lookUpDictionary(
      {required LookUpDictionaryParams lookUpDictionaryParams}) async {
    try {
      final response = await dio.get(
          '/word/look-up-dictionary?key=${lookUpDictionaryParams.key}',
          queryParameters: {},
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<List<WordModel>>.fromJson(
          json: response.data,
          fromJsonD: (jsonWords) => jsonWords['results']
              ?.map<WordModel>((json) => WordModel.fromJson(json: json))
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
  Future<ResponseDataModel<List<ObjectModel>>> lookUpByImage(
      {required LookUpByImageParams lookUpByImageParams}) async {
    try {
      final String visonKey = dotenv.env['VISON_KEY']!;
      final fileBytes = File(lookUpByImageParams.file.path).readAsBytesSync();

      dio.options.baseUrl =
          'https://ctue-mobile-app.cognitiveservices.azure.com';

      final response = await dio.post('/computervision/imageanalysis:analyze',
          data: fileBytes,
          queryParameters: {
            'features': [
              // 'caption',
              // 'dense-aptions',
              'objects',
              // 'people',
              // 'read',
              // 'smart-crops',
              // 'tags'
            ],
            'language': 'en',
            'api-version': '2024-02-01'
          },
          options: Options(headers: {
            "Ocp-Apim-Subscription-Key": visonKey,
            'Content-Type': 'application/octet-stream',
            // 'Content-Type': 'multipart/form-data',
          }));

      dio.options.baseUrl = 'https://ctue-learn-english-api.onrender.com/apis';

      return ResponseDataModel<List<ObjectModel>>.fromJson(
          json: response,
          fromJsonD: (json) {
            final List<dynamic> results = [];
            final values = json['objectsResult']['values'];
            values.forEach((a) {
              results.addAll(a['tags']);
            });
            return results.map((e) => ObjectModel.fromJson(json: e)).toList();
          });
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
