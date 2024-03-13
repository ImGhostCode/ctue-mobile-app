import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class SpeechRepository {
  Future<Either<Failure, ResponseDataModel<List<VoiceEntity>>>> getVoices({
    required GetVoiceParams getVoiceParams,
  });

  Future<Either<Failure, ResponseDataModel<List<int>>>> textToSpeech({
    required TTSParams ttsParams,
  });
}