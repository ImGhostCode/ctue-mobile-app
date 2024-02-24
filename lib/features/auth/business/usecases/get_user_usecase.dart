import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/business/entities/user_entity.dart';
import 'package:ctue_app/features/auth/business/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase {
  final AuthRepository authRepository;

  GetUserUsecase({required this.authRepository});

  Future<Either<Failure, ResponseDataModel<UserEntity>>> call({
    required GetUserParams getUserParams,
  }) async {
    return await authRepository.getUser(getUserParams: getUserParams);
  }
}
