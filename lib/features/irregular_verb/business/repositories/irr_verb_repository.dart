import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class IrrVerbRepository {
  Future<Either<Failure, ResponseDataModel<IrrVerbResEntity>>> getIrrVerbs({
    required IrrVerbParams irrVerbParams,
  });
}
