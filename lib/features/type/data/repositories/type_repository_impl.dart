import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/business/repositories/type_repository.dart';
import 'package:ctue_app/features/type/data/datasources/type_local_data_source.dart';
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
  Future<Either<Failure, ResponseDataModel<List<TypeModel>>>> getTypes(
      {required TypeParams typeParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<TypeModel>> remoteType =
            await remoteDataSource.getTypes(typeParams: typeParams);

        localDataSource.cacheType(typeModel: remoteType);

        return Right(remoteType);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<TypeModel>> localTypes =
            await localDataSource.getLastType();
        return Right(localTypes);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }
}
