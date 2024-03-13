import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/level_params.dart';
import 'package:ctue_app/features/level/business/entities/level_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class LevelRepository {
  Future<Either<Failure, ResponseDataModel<List<LevelEntity>>>> getLevels({
    required LevelParams levelParams,
  });
}