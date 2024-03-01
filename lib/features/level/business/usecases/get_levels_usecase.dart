import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/level_params.dart';
import 'package:ctue_app/features/level/business/entities/level_entity.dart';
import 'package:ctue_app/features/level/business/repositories/level_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetLevelsUsecase {
  final LevelRepository levelRepository;

  GetLevelsUsecase({required this.levelRepository});

  Future<Either<Failure, ResponseDataModel<List<LevelEntity>>>> call({
    required LevelParams levelParams,
  }) async {
    return await levelRepository.getLevels(levelParams: levelParams);
  }
}
