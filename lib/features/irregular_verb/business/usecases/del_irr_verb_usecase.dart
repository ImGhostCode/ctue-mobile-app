import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/features/irregular_verb/business/repositories/irr_verb_repository.dart';

import 'package:dartz/dartz.dart';

class DeleteIrrVerbUsecase {
  final IrrVerbRepository irrVerbRepository;

  DeleteIrrVerbUsecase({required this.irrVerbRepository});

  Future<Either<Failure, ResponseDataModel<void>>> call({
    required DeleteIrrVerbParams deleteIrrVerbParams,
  }) async {
    return await irrVerbRepository.deleteIrrVerb(
        deleteIrrVerbParams: deleteIrrVerbParams);
  }
}
