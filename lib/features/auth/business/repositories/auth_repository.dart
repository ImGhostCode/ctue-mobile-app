import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/business/entities/access_token_entity.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/auth/business/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResponseDataModel<AccessTokenEntity>>> login({
    required LoginParams loginParams,
  });
  Future<Either<Failure, ResponseDataModel<AccountEntity>>> signup({
    required SignupParams signupParams,
  });
}
