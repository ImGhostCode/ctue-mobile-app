import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/learn_repository.dart';

class CreVocaSetUsecase {
  final LearnRepository learnRepository;

  CreVocaSetUsecase({required this.learnRepository});

  // Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> call({
  //   required CreVocaSetParams creVocaSetParams,
  // }) async {
  //   return await vocaSetRepository.createVocaSet(
  //       creVocaSetParams: creVocaSetParams);
  // }
}
