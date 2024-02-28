import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/user_params.dart';
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
}
