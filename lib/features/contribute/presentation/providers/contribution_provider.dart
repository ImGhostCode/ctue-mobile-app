import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';
import 'package:ctue_app/features/contribute/business/usecases/create_sen_contribution.dart';
import 'package:ctue_app/features/contribute/business/usecases/create_word_contribution.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/datasources/template_local_data_source.dart';
import '../../data/datasources/contribution_remote_data_source.dart';
import '../../data/repositories/con_repository_impl.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class ContributionProvider extends ChangeNotifier {
  ContributionEntity? contributionEntity;
  Failure? failure;
  String? message = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  ContributionProvider({
    this.contributionEntity,
    this.failure,
  });

  Future eitherFailureOrCreWordCon(String type, Content content) async {
    _isLoading = true;
    ContributionRepositoryImpl repository = ContributionRepositoryImpl(
      remoteDataSource: ContributionRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWordContribution =
        await CreateWordConUsecase(contributionRepository: repository).call(
      createWordConParams: CreateWordConParams(
          type: type,
          content: content,
          accessToken: await storage.read(key: 'accessToken') ?? ''),
    );

    failureOrWordContribution.fold(
      (Failure newFailure) {
        _isLoading = false;
        contributionEntity = null;
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<ContributionEntity> newContribution) {
        _isLoading = false;
        contributionEntity = newContribution.data;
        message = newContribution.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrCreSenCon(String type, Content content) async {
    _isLoading = true;
    ContributionRepositoryImpl repository = ContributionRepositoryImpl(
      remoteDataSource: ContributionRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrWordContribution =
        await CreateSenConUsecase(contributionRepository: repository).call(
      createSenConParams: CreateSenConParams(
          type: type,
          content: content,
          accessToken: await storage.read(key: 'accessToken') ?? ''),
    );

    failureOrWordContribution.fold(
      (Failure newFailure) {
        _isLoading = false;
        contributionEntity = null;
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<ContributionEntity> newContribution) {
        _isLoading = false;
        contributionEntity = newContribution.data;
        message = newContribution.message;
        failure = null;
        notifyListeners();
      },
    );
  }
}
