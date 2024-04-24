import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/business/entities/learn_response_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/learn_repository.dart';

class GetLearningHistoryUsecase {
  final LearnRepository learnRepository;

  GetLearningHistoryUsecase({required this.learnRepository});

  Future<Either<Failure, ResponseDataModel<LearnResEntity>>> call({
    required GetLearningHistoryParams getLearningHistoryParams,
  }) async {
    return await learnRepository.getLearningHistory(
        getLearningHistoryParams: getLearningHistoryParams);
  }
}
