import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/irr_verb_entity.dart';

abstract class IrrVerbRepository {
  Future<Either<Failure, ResponseDataModel<List<IrrVerbEntity>>>> getIrrVerbs({
    required IrrVerbParams irrVerbParams,
  });
}
