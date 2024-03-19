import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
// import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository authRepository;

  SignUpUsecase({required this.authRepository});

  Future<Either<Failure, ResponseDataModel<AccountEntity>>> call({
    required SignupParams signupParams,
  }) async {
    return await authRepository.signup(signupParams: signupParams);
  }
}
