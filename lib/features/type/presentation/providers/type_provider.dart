import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/business/usecases/get_types_of_sentence.dart';
import 'package:ctue_app/features/type/data/repositories/type_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/template_entity.dart';
import '../../business/usecases/get_template.dart';
import '../../data/datasources/template_local_data_source.dart';
import '../../data/datasources/type_remote_data_source.dart';
import '../../data/repositories/template_repository_impl.dart';

class TypeProvider extends ChangeNotifier {
  TypeEntity? typeEntity;
  Failure? failure;

  TypeProvider({
    this.typeEntity,
    this.failure,
  });

  void eitherFailureOrTypesOfSentece(int id, bool isWord) async {
    TypeRepositoryImpl repository = TypeRepositoryImpl(
      remoteDataSource: TypeRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: TypeLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrType = await GetTypeUsecase(typeRepository: repository).call(
      typeParams: TypeParams(id: id, isWord: isWord),
    );

    failureOrType.fold(
      (Failure newFailure) {
        typeEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<TypeEntity> newTypes) {
        typeEntity = newTypes.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
