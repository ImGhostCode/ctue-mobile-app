import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/business/repositories/type_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetTypeUsecase {
  final TypeRepository typeRepository;

  GetTypeUsecase({required this.typeRepository});

  Future<Either<Failure, ResponseDataModel<TypeEntity>>> call({
    required TypeParams typeParams,
  }) async {
    return await typeRepository.getTypes(typeParams: typeParams);
  }
}
