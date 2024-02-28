import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/user/business/repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class UpdateUserUsecase {
  final UserRepository userRepository;

  UpdateUserUsecase({required this.userRepository});

  Future<Either<Failure, ResponseDataModel<UserEntity>>> call({
    required UpdateUserParams updateUserParams,
  }) async {
    return await userRepository.updateUser(updateUserParams: updateUserParams);
  }
}
