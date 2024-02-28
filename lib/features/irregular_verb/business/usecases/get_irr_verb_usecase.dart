import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/irr_verb_entity.dart';
import '../repositories/irr_verb_repository.dart';

class GetIrrVerb {
  final IrrVerbRepository irrVerbRepository;

  GetIrrVerb({required this.irrVerbRepository});

  Future<Either<Failure, ResponseDataModel<List<IrrVerbEntity>>>> call({
    required IrrVerbParams irrVerbParams,
  }) async {
    return await irrVerbRepository.getIrrVerbs(irrVerbParams: irrVerbParams);
  }
}
