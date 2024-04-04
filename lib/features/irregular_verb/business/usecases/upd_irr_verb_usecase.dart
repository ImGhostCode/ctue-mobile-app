import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_entity.dart';
import 'package:ctue_app/features/irregular_verb/business/repositories/irr_verb_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class UpdateIrrVerbUsecase {
  final IrrVerbRepository irrVerbRepository;

  UpdateIrrVerbUsecase({required this.irrVerbRepository});

  Future<Either<Failure, ResponseDataModel<IrrVerbEntity>>> call({
    required UpdateIrrVerbParams updateIrrVerbParams,
  }) async {
    return await irrVerbRepository.updateIrrVerb(
        updateIrrVerbParams: updateIrrVerbParams);
  }
}
