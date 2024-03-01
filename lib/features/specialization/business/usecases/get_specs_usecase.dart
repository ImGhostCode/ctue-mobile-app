import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/specialization_params.dart';
import 'package:ctue_app/features/specialization/business/entities/specialization_entity.dart';
import 'package:ctue_app/features/specialization/business/repositories/spec_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetSpecializationsUsecase {
  final SpecializationRepository specRepository;

  GetSpecializationsUsecase({required this.specRepository});

  Future<Either<Failure, ResponseDataModel<List<SpecializationEntity>>>> call({
    required SpecializationParams specializationParams,
  }) async {
    return await specRepository.getSpecializations(
        specializationParams: specializationParams);
  }
}
