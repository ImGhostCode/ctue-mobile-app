import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/word_store/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/word_store/business/usecases/get_usr_voca_sets.dart';
import 'package:ctue_app/features/word_store/business/usecases/get_voca_set_detail.dart';
import 'package:ctue_app/features/word_store/business/usecases/get_voca_sets.dart';
import 'package:ctue_app/features/word_store/data/datasources/voca_set_local_data_source.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/usecases/create_voca_set.dart';

import '../../data/datasources/voca_set_remote_data_source.dart';
import '../../data/repositories/voca_set_repository_impl.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class VocaSetProvider extends ChangeNotifier {
  VocaSetEntity? vocaSetEntity;
  List<VocaSetEntity> userVocaSets = [];
  List<VocaSetEntity> publicVocaSets = [];

  Failure? failure;
  String? message = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  VocaSetProvider({
    this.vocaSetEntity,
    this.failure,
  });

  Future eitherFailureOrCreVocaSet(String title, int? topicid, int? specId,
      XFile? picture, List<int> words) async {
    _isLoading = true;
    VocaSetRepositoryImpl repository = VocaSetRepositoryImpl(
      remoteDataSource: VocaSetRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: VocaSetLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrCreVocaSet =
        await CreVocaSetUsecase(vocaSetRepository: repository).call(
      creVocaSetParams: CreVocaSetParams(
          title: title,
          topicId: topicid,
          specId: specId,
          picture: picture,
          words: words,
          accessToken: await storage.read(key: 'accessToken') ?? ''),
    );

    failureOrCreVocaSet.fold(
      (Failure newFailure) {
        _isLoading = false;
        vocaSetEntity = null;
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<VocaSetEntity> newVocaSet) {
        _isLoading = false;
        vocaSetEntity = newVocaSet.data;
        message = newVocaSet.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrGerUsrVocaSets() async {
    _isLoading = true;
    VocaSetRepositoryImpl repository = VocaSetRepositoryImpl(
      remoteDataSource: VocaSetRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: VocaSetLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrGetUsrVocaSets =
        await GetUsrVocaSetUsecase(vocaSetRepository: repository).call(
      getVocaSetParams: GetVocaSetParams(
          accessToken: await storage.read(key: 'accessToken') ?? ''),
    );

    failureOrGetUsrVocaSets.fold(
      (Failure newFailure) {
        _isLoading = false;
        userVocaSets = [];
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<List<VocaSetEntity>> newVocaSets) {
        _isLoading = false;
        userVocaSets = newVocaSets.data;
        message = newVocaSets.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrGerVocaSets(
      int? specId, int? topicId, String? key) async {
    _isLoading = true;
    VocaSetRepositoryImpl repository = VocaSetRepositoryImpl(
      remoteDataSource: VocaSetRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: VocaSetLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrGetVocaSets =
        await GetVocaSetUsecase(vocaSetRepository: repository).call(
      getVocaSetParams: GetVocaSetParams(
          specId: specId,
          topicId: topicId,
          key: key,
          accessToken: await storage.read(key: 'accessToken') ?? ''),
    );

    failureOrGetVocaSets.fold(
      (Failure newFailure) {
        _isLoading = false;
        publicVocaSets = [];
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<List<VocaSetEntity>> newVocaSets) {
        _isLoading = false;
        publicVocaSets = newVocaSets.data;
        message = newVocaSets.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrGerVocaSetDetail(int id) async {
    _isLoading = true;
    VocaSetRepositoryImpl repository = VocaSetRepositoryImpl(
      remoteDataSource: VocaSetRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: VocaSetLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrCreVocaSet =
        await GetVocaSetDetailUsecase(vocaSetRepository: repository).call(
      getVocaSetParams: GetVocaSetParams(
          id: id, accessToken: await storage.read(key: 'accessToken') ?? ''),
    );

    failureOrCreVocaSet.fold(
      (Failure newFailure) {
        _isLoading = false;
        vocaSetEntity = null;
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<VocaSetEntity> newVocaSet) {
        _isLoading = false;
        vocaSetEntity = newVocaSet.data;
        message = newVocaSet.message;
        failure = null;
        notifyListeners();
      },
    );
  }
}
