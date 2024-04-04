import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_response_entity.dart';
import 'package:ctue_app/features/irregular_verb/business/usecases/cre_irr_verb_usecase.dart';
import 'package:ctue_app/features/irregular_verb/business/usecases/del_irr_verb_usecase.dart';
import 'package:ctue_app/features/irregular_verb/business/usecases/upd_irr_verb_usecase.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/entities/irr_verb_entity.dart';
import '../../business/usecases/get_irr_verb_usecase.dart';
import '../../data/datasources/irr_verb_local_data_source.dart';
import '../../data/datasources/irr_verb_remote_data_source.dart';
import '../../data/repositories/irr_verb_repository_impl.dart';

class IrrVerbProvider extends ChangeNotifier {
  final secureStorage = SecureStorageService.secureStorage;
  List<IrrVerbEntity>? listIrrVerbs = [];
  Failure? failure;
  bool _isLoading = false;
  IrrVerbResEntity? irrVerbResEntity;
  String? message;
  int? statusCode;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IrrVerbProvider({
    this.listIrrVerbs,
    this.failure,
  });

  Future eitherFailureOrIrrVerbs(int? page, String? sort, String? key) async {
    _isLoading = true;
    IrrVerbRepositoryImpl repository = IrrVerbRepositoryImpl(
      remoteDataSource: IrrVerbRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: IrrVerbLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrIrrVerb =
        await GetIrrVerb(irrVerbRepository: repository).call(
      irrVerbParams: IrrVerbParams(page: page, sort: sort, key: key),
    );

    failureOrIrrVerb.fold(
      (Failure newFailure) {
        _isLoading = false;
        irrVerbResEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<IrrVerbResEntity> newIrrVerbs) {
        _isLoading = false;
        irrVerbResEntity = newIrrVerbs.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrCreIrrVerb(
    String v1,
    String v2,
    String v3,
    String meaning,
  ) async {
    isLoading = true;
    IrrVerbRepositoryImpl repository = IrrVerbRepositoryImpl(
      remoteDataSource: IrrVerbRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: IrrVerbLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrIrrVerb =
        await CreateIrrVerbUsecase(irrVerbRepository: repository).call(
      createIrrVerbParams: CreateIrrVerbParams(
          v1: v1,
          v2: v2,
          v3: v3,
          meaning: meaning,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrIrrVerb.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;

        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<IrrVerbEntity> newIrrVerbs) {
        isLoading = false;
        statusCode = newIrrVerbs.statusCode;
        message = newIrrVerbs.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrUpdateIrrVerb(
    int irrVerbId,
    String v1,
    String v2,
    String v3,
    String meaning,
  ) async {
    isLoading = true;
    IrrVerbRepositoryImpl repository = IrrVerbRepositoryImpl(
      remoteDataSource: IrrVerbRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: IrrVerbLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrIrrVerb =
        await UpdateIrrVerbUsecase(irrVerbRepository: repository).call(
      updateIrrVerbParams: UpdateIrrVerbParams(
          irrVerbId: irrVerbId,
          v1: v1,
          v2: v2,
          v3: v3,
          meaning: meaning,
          accessToken: await secureStorage.read(key: 'accessToken') ?? ''),
    );

    failureOrIrrVerb.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;

        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<IrrVerbEntity> newIrrVerbs) {
        isLoading = false;
        statusCode = newIrrVerbs.statusCode;
        message = newIrrVerbs.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrDelIrrVerb(int irrVerbId) async {
    isLoading = true;
    IrrVerbRepositoryImpl repository = IrrVerbRepositoryImpl(
      remoteDataSource: IrrVerbRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: IrrVerbLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrDeleteIrrVerb =
        await DeleteIrrVerbUsecase(irrVerbRepository: repository).call(
      deleteIrrVerbParams: DeleteIrrVerbParams(
        accessToken: await secureStorage.read(key: 'accessToken') ?? '',
        irrVerbId: irrVerbId,
      ),
    );
    failureOrDeleteIrrVerb.fold(
      (Failure newFailure) {
        isLoading = false;
        statusCode = 400;
        message = newFailure.errorMessage;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<void> result) {
        isLoading = false;
        statusCode = result.statusCode;
        message = result.message;
        failure = null;
        notifyListeners();
      },
    );
  }
}
