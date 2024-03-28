import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LearnRepository {
  Future<Either<Failure, ResponseDataModel<List<UserLearnedWordEntity>>>>
      saveLearnedResult({
    required SaveLearnedResultParams saveLearnedResultParams,
  });
}
