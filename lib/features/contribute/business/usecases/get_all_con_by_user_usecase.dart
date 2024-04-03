import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/business/entities/contri_response_entity.dart';
import 'package:ctue_app/features/contribute/business/repositories/contribution_repositoty.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetAllConByUserUsecase {
  final ContributionRepository contributionRepository;

  GetAllConByUserUsecase({required this.contributionRepository});

  Future<Either<Failure, ResponseDataModel<ContributionResEntity>>> call({
    required GetAllConByUserParams getAllConByUserParams,
  }) async {
    return await contributionRepository.getAllConByUser(
        getAllConByUserParams: getAllConByUserParams);
  }
}
