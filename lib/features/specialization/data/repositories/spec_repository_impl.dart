import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/specialization_params.dart';
import 'package:ctue_app/features/specialization/business/repositories/spec_repository.dart';
import 'package:ctue_app/features/specialization/data/datasources/spec_remote_data_source.dart';
import 'package:ctue_app/features/specialization/data/datasources/spec_local_data_source.dart';
import 'package:ctue_app/features/specialization/data/models/specialization_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class SpecRepositoryImpl implements SpecializationRepository {
  final SpecRemoteDataSource remoteDataSource;
  final SpecializationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SpecRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<SpecializationModel>>>>
      getSpecializations(
          {required SpecializationParams specializationParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<SpecializationModel>> remoteSpecialization =
            await remoteDataSource.getSpecializations(
                specializationParams: specializationParams);

        localDataSource.cacheSpecialization(
            specializationModel: remoteSpecialization);

        return Right(remoteSpecialization);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<SpecializationModel>> localSpecializations =
            await localDataSource.getLastSpecialization();
        return Right(localSpecializations);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }
}
