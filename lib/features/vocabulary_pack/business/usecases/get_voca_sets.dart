import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/voca_set_repository.dart';

class GetVocaSetUsecase {
  final VocaSetRepository vocaSetRepository;

  GetVocaSetUsecase({required this.vocaSetRepository});

  Future<Either<Failure, ResponseDataModel<List<VocaSetEntity>>>> call({
    required GetVocaSetParams getVocaSetParams,
  }) async {
    return await vocaSetRepository.getVocaSets(
        getVocaSetParams: getVocaSetParams);
  }
}
