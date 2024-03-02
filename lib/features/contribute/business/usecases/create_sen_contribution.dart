import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';
import 'package:ctue_app/features/contribute/business/repositories/contribution_repositoty.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class CreateSenConUsecase {
  final ContributionRepository contributionRepository;

  CreateSenConUsecase({required this.contributionRepository});

  Future<Either<Failure, ResponseDataModel<ContributionEntity>>> call({
    required CreateSenConParams createSenConParams,
  }) async {
    return await contributionRepository.createSenContribution(
        createSenConParams: createSenConParams);
  }
}
