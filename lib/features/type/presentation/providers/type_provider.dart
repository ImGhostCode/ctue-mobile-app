import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/business/usecases/get_types_usecase.dart';
import 'package:ctue_app/features/type/data/repositories/type_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/datasources/template_local_data_source.dart';
import '../../data/datasources/type_remote_data_source.dart';

class TypeProvider extends ChangeNotifier {
  TypeEntity? typeEntity;
  List<TypeEntity> listTypes = [];
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  TypeProvider({
    this.typeEntity,
    this.failure,
  });

  Future eitherFailureOrGetTypes(bool isWord) async {
    _isLoading = true;
    TypeRepositoryImpl repository = TypeRepositoryImpl(
      remoteDataSource: TypeRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TypeLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrType =
        await GetTypesUsecase(typeRepository: repository).call(
      typeParams: TypeParams(isWord: isWord),
    );

    failureOrType.fold(
      (Failure newFailure) {
        _isLoading = false;
        listTypes = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<TypeEntity>> newTypes) {
        _isLoading = false;
        listTypes = newTypes.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
