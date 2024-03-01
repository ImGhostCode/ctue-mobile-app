import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/business/repositories/type_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetTypesUsecase {
  final TypeRepository typeRepository;

  GetTypesUsecase({required this.typeRepository});

  Future<Either<Failure, ResponseDataModel<List<TypeEntity>>>> call({
    required TypeParams typeParams,
  }) async {
    return await typeRepository.getTypes(typeParams: typeParams);
  }
}
