import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/speech/business/repositories/speech_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class TtsUsecase {
  final SpeechRepository speechRepository;

  TtsUsecase({required this.speechRepository});

  Future<Either<Failure, ResponseDataModel<List<int>>>> call({
    required TTSParams ttsParams,
  }) async {
    return await speechRepository.textToSpeech(ttsParams: ttsParams);
  }
}
