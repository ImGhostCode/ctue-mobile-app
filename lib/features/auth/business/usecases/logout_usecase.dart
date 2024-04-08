import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
// import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  Future<Either<Failure, ResponseDataModel<void>>> call({
    required LogoutParams logoutParams,
  }) async {
    return await authRepository.logout(logoutParams: logoutParams);
  }
}
