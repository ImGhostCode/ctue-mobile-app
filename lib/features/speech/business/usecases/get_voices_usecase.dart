import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:ctue_app/features/speech/business/repositories/speech_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetVoiceUsecase {
  final SpeechRepository speechRepository;

  GetVoiceUsecase({required this.speechRepository});

  Future<Either<Failure, ResponseDataModel<List<VoiceEntity>>>> call({
    required GetVoiceParams getVoiceParams,
  }) async {
    return await speechRepository.getVoices(getVoiceParams: getVoiceParams);
  }
}
