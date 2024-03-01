import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/template_entity.dart';

abstract class ContributionRepository {
  Future<Either<Failure, ResponseDataModel<ContributionEntity>>>
      createWordContribution({
    required CreateWordConParams createWordConParams,
  });
}
