import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class TypeRepository {
  Future<Either<Failure, ResponseDataModel<List<TypeEntity>>>> getTypes({
    required TypeParams typeParams,
  });
}
