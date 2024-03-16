import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/speech/business/entities/prounc_statistics_entity.dart';
import 'package:ctue_app/features/speech/business/repositories/speech_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetUserPronuncStatisticUsecase {
  final SpeechRepository speechRepository;

  GetUserPronuncStatisticUsecase({required this.speechRepository});

  Future<Either<Failure, ResponseDataModel<PronuncStatisticEntity>>> call({
    required GetUserProStatisticParams getUserProStatisticParams,
  }) async {
    return await speechRepository.getUserProStatistics(
        getUserProStatisticParams: getUserProStatisticParams);
  }
}
