import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/speech/business/entities/pronunc_assessment_entity.dart';
import 'package:ctue_app/features/speech/business/entities/prounc_statistics_entity.dart';
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

  Future<Either<Failure, ResponseDataModel<PronuncAssessmentEntity?>>>
      evaluateSpeechPronun({
    required EvaluateSpeechPronunParams evaluateSpeechPronunParams,
  });
  Future<Either<Failure, ResponseDataModel<PronuncStatisticEntity>>>
      getUserProStatistics({
    required GetUserProStatisticParams getUserProStatisticParams,
  });
}
