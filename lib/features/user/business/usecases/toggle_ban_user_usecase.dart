import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/features/user/business/repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class ToggleBanUserUsecase {
  final UserRepository userRepository;

  ToggleBanUserUsecase({required this.userRepository});

  Future<Either<Failure, ResponseDataModel<void>>> call({
    required ToggleBanUserParams toggleBanUserParams,
  }) async {
    return await userRepository.toggleBanUser(
        toggleBanUserParams: toggleBanUserParams);
  }
}
