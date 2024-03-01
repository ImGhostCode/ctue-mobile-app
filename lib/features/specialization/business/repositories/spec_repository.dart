import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/specialization_params.dart';
import 'package:ctue_app/features/specialization/business/entities/specialization_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class SpecializationRepository {
  Future<Either<Failure, ResponseDataModel<List<SpecializationEntity>>>>
      getSpecializations({
    required SpecializationParams specializationParams,
  });
}
