import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/learn_repository.dart';

class SaveLearnedResultUsecase {
  final LearnRepository learnRepository;

  SaveLearnedResultUsecase({required this.learnRepository});

  Future<Either<Failure, ResponseDataModel<List<UserLearnedWordEntity>>>> call({
    required SaveLearnedResultParams saveLearnedResultParams,
  }) async {
    return await learnRepository.saveLearnedResult(
        saveLearnedResultParams: saveLearnedResultParams);
  }
}
