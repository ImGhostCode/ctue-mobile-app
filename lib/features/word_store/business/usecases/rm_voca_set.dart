import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/word_store/business/entities/voca_set_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/voca_set_repository.dart';

class RemoveVocaSetUsecase {
  final VocaSetRepository vocaSetRepository;

  RemoveVocaSetUsecase({required this.vocaSetRepository});

  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> call({
    required RemoveVocaSetParams removeVocaSetParams,
  }) async {
    return await vocaSetRepository.removeVocaSet(
        removeVocaSetParams: removeVocaSetParams);
  }
}