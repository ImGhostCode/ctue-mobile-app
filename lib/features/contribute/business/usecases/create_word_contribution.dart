import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';
import 'package:ctue_app/features/contribute/business/repositories/contribution_repositoty.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/template_entity.dart';
import '../repositories/template_repository.dart';

class CreateWordConUsecase {
  final ContributionRepository contributionRepository;

  CreateWordConUsecase({required this.contributionRepository});

  Future<Either<Failure, ResponseDataModel<ContributionEntity>>> call({
    required CreateWordConParams createWordConParams,
  }) async {
    return await contributionRepository.createWordContribution(
        createWordConParams: createWordConParams);
  }
}
