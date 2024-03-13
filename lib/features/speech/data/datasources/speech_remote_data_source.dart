import 'dart:async';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/speech/data/models/voice_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class SpeechRemoteDataSource {
  Future<ResponseDataModel<List<VoiceModel>>> getVoices(
      {required GetVoiceParams getVoiceParams});
  Future<ResponseDataModel<List<int>>> tts({required TTSParams ttsParams});
}

class SpeechRemoteDataSourceImpl implements SpeechRemoteDataSource {
  final Dio dio;
  SpeechRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<List<VoiceModel>>> getVoices(
      {required GetVoiceParams getVoiceParams}) async {
    try {
      final String speechRegion = dotenv.env['SPEECH_REGION']!;
      final String speechKey = dotenv.env['SPEECH_KEY']!;

      dio.options.baseUrl = 'https://$speechRegion.tts.speech.microsoft.com';

      final response = await dio.get('/cognitiveservices/voices/list',
          queryParameters: {
            'api_key': 'if needed',
          },
          options: Options(headers: {"Ocp-Apim-Subscription-Key": speechKey}));

      dio.options.baseUrl = 'https://ctue-learn-english-api.onrender.com/apis';

      return ResponseDataModel<List<VoiceModel>>.fromJson(
        json: response,
        fromJsonD: (jsonVoices) => jsonVoices
            ?.map<VoiceModel>((json) => VoiceModel.fromJson(json: json))
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
  Future<ResponseDataModel<List<int>>> tts(
      {required TTSParams ttsParams}) async {
    try {
      final String speechRegion = dotenv.env['SPEECH_REGION']!;
      final String speechKey = dotenv.env['SPEECH_KEY']!;

      dio.options.baseUrl = 'https://$speechRegion.tts.speech.microsoft.com';

      List<int> audioChunks = [];
      final response = await dio.post('/cognitiveservices/v1',
          data: """
<speak version='1.0' xml:lang='${ttsParams.voice.locale}'><voice xml:lang='${ttsParams.voice.locale}' xml:gender='${ttsParams.voice.gender}'
    name='${ttsParams.voice.shortName}'>
        ${ttsParams.text}
</voice></speak>""",
          queryParameters: {
            'api_key': 'if needed',
          },
          options: Options(headers: {
            // 'Host': 'https://$speechRegion.tts.speech.microsoft.com',
            "Ocp-Apim-Subscription-Key": speechKey,
            'X-Microsoft-OutputFormat': 'riff-24khz-16bit-mono-pcm',
            'Content-Type': 'application/ssml+xml',
          }, responseType: ResponseType.stream));

      await response.data.stream.forEach((chunk) {
        audioChunks.addAll(chunk);
      });

      dio.options.baseUrl = 'https://ctue-learn-english-api.onrender.com/apis';

      return ResponseDataModel<List<int>>.fromJson(
        json: response,
        fromJsonD: (json) => audioChunks,
      );
    } on DioException catch (e) {
      // _audioStreamController.close();
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
