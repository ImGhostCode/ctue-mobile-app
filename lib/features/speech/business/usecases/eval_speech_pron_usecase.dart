import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/speech/business/entities/pronunc_assessment_entity.dart';
import 'package:ctue_app/features/speech/business/repositories/speech_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class EvalSpeechPronucUsecase {
  final SpeechRepository speechRepository;

  EvalSpeechPronucUsecase({required this.speechRepository});

  Future<Either<Failure, ResponseDataModel<PronuncAssessmentEntity?>>> call({
    required EvaluateSpeechPronunParams evaluateSpeechPronunParams,
  }) async {
    return await speechRepository.evaluateSpeechPronun(
        evaluateSpeechPronunParams: evaluateSpeechPronunParams);
  }
}
