import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/learn_repository.dart';

class GetUsrLearnedWordUsecase {
  final LearnRepository learnRepository;

  GetUsrLearnedWordUsecase({required this.learnRepository});

  Future<Either<Failure, ResponseDataModel<List<UserLearnedWordEntity>>>> call({
    required GetUserLearnedWordParams getUserLearnedWordParams,
  }) async {
    return await learnRepository.getUserLearnedWords(
        getUserLearnedWordParams: getUserLearnedWordParams);
  }
}
