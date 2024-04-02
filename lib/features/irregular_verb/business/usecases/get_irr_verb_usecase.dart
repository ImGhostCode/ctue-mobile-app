import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_response_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/irr_verb_repository.dart';

class GetIrrVerb {
  final IrrVerbRepository irrVerbRepository;

  GetIrrVerb({required this.irrVerbRepository});

  Future<Either<Failure, ResponseDataModel<IrrVerbResEntity>>> call({
    required IrrVerbParams irrVerbParams,
  }) async {
    return await irrVerbRepository.getIrrVerbs(irrVerbParams: irrVerbParams);
  }
}
