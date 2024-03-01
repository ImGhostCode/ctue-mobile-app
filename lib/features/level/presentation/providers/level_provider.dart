import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/level_params.dart';
import 'package:ctue_app/features/level/business/entities/level_entity.dart';
import 'package:ctue_app/features/level/business/usecases/get_levels_usecase.dart';
import 'package:ctue_app/features/level/data/datasources/level_remote_data_source.dart';
import 'package:ctue_app/features/level/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/level/data/repositories/level_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class LevelProvider extends ChangeNotifier {
  LevelEntity? levelEntity;
  List<LevelEntity> listLevels = [];
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  LevelProvider({
    this.levelEntity,
    this.failure,
  });

  void eitherFailureOrGetLevels() async {
    _isLoading = true;
    LevelRepositoryImpl repository = LevelRepositoryImpl(
      remoteDataSource: LevelRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: LevelLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrLevel =
        await GetLevelsUsecase(levelRepository: repository).call(
      levelParams: LevelParams(),
    );

    failureOrLevel.fold(
      (Failure newFailure) {
        _isLoading = false;
        listLevels = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<LevelEntity>> newLevels) {
        _isLoading = false;
        listLevels = newLevels.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
