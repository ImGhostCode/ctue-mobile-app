import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/auth/data/models/access_token_model.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/business/repositories/type_repository.dart';
import 'package:ctue_app/features/type/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/type/data/datasources/type_remote_data_source.dart';
import 'package:ctue_app/features/type/data/models/type_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class TypeRepositoryImpl implements TypeRepository {
  final TypeRemoteDataSource remoteDataSource;
  final TypeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TypeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<TypeModel>>> getTypes(
      {required TypeParams typeParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<TypeModel> remoteType =
            await remoteDataSource.getTypes(typeParams: typeParams);

        // localDataSource.cacheAuth(AuthToCache: remoteType);

        return Right(remoteType);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      // try {
      // AccessTokenModel localAuth = await localDataSource.getLastAuth();
      //   return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
      // }
    }
  }
}