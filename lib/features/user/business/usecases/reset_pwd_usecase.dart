import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/features/user/business/repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class ResetPasswordUsecase {
  final UserRepository userRepository;

  ResetPasswordUsecase({required this.userRepository});

  Future<Either<Failure, ResponseDataModel<void>>> call({
    required ResetPasswordParams resetPasswordParams,
  }) async {
    return await userRepository.resetPassword(
        resetPasswordParams: resetPasswordParams);
  }
}
