import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, ResponseDataModel<UserEntity>>> getUser({
    required GetUserParams getUserParams,
  });
  Future<Either<Failure, ResponseDataModel<UserEntity>>> updateUser({
    required UpdateUserParams updateUserParams,
  });
  Future<Either<Failure, ResponseDataModel<void>>> resetPassword({
    required ResetPasswordParams resetPasswordParams,
  });
  Future<Either<Failure, ResponseDataModel<void>>> getVerifyCode({
    required GetVerifyCodeParams getVerifyCodeParams,
  });
  Future<Either<Failure, ResponseDataModel<List<AccountEntity>>>> getAllUser({
    required GetAllUserParams getAllUserParams,
  });
}
