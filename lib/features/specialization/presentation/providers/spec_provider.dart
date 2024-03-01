import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/specialization_params.dart';
import 'package:ctue_app/features/specialization/business/entities/specialization_entity.dart';
import 'package:ctue_app/features/specialization/business/usecases/get_specs_usecase.dart';
import 'package:ctue_app/features/specialization/data/datasources/spec_remote_data_source.dart';
import 'package:ctue_app/features/specialization/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/specialization/data/repositories/spec_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class SpecializationProvider extends ChangeNotifier {
  SpecializationEntity? specializationEntity;
  List<SpecializationEntity> listSpecializations = [];
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SpecializationProvider({
    this.specializationEntity,
    this.failure,
  });

  void eitherFailureOrGetSpecializations() async {
    _isLoading = true;
    SpecRepositoryImpl repository = SpecRepositoryImpl(
      remoteDataSource: SpecRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: SpecLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSpecialization =
        await GetSpecializationsUsecase(specRepository: repository).call(
      specializationParams: SpecializationParams(),
    );

    failureOrSpecialization.fold(
      (Failure newFailure) {
        _isLoading = false;
        listSpecializations = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<SpecializationEntity>> newSpecializations) {
        _isLoading = false;
        listSpecializations = newSpecializations.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
