import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/business/repositories/contribution_repositoty.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class VerifyContributionUsecase {
  final ContributionRepository contributionRepository;

  VerifyContributionUsecase({required this.contributionRepository});

  Future<Either<Failure, ResponseDataModel<void>>> call({
    required VerifyConParams verifyConParams,
  }) async {
    return await contributionRepository.verifyContribution(
        verifyConParams: verifyConParams);
  }
}
