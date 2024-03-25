import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
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
  List<IrrVerbEntity>? listIrrVerbs = [];
  Failure? failure;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IrrVerbProvider({
    this.listIrrVerbs,
    this.failure,
  });

  void eitherFailureOrIrrVerbs(int? page, String? sort, String? key) async {
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
        listIrrVerbs = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<IrrVerbEntity>> newIrrVerbs) {
        _isLoading = false;
        listIrrVerbs = newIrrVerbs.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
