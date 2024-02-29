import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';
import 'package:ctue_app/features/extension/business/usecases/check_is_favorite.dart';
import 'package:ctue_app/features/extension/business/usecases/get_favorites.dart';
import 'package:ctue_app/features/extension/business/usecases/toggle_favorite.dart';
import 'package:ctue_app/features/extension/data/datasources/favotire_remote_data_source.dart';
import 'package:ctue_app/features/extension/data/repositories/favorite_respository_impl.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class FavoriteProvider extends ChangeNotifier {
  List<WordEntity>? favoriteList = [];
  FavoriteEntity? favoriteEntity;
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool isFavorite = false;

  // set isLoading(bool value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  FavoriteProvider({
    this.favoriteList,
    this.favoriteEntity,
    this.failure,
  });

  bool checkIsFavorite(int id) {
    for (var item in favoriteList!) {
      if (item.id == id) {
        return true;
      }
    }
    return false;
  }

  Future eitherFailureOrGetFavorites(int page, String sort, String key) async {
    _isLoading = true;
    FavoriteRepositoryImpl repository = FavoriteRepositoryImpl(
      remoteDataSource: FavoriteRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrFavorite =
        await GetFavoriteUsecase(favoriteRepository: repository).call(
      getFavoritesParams: GetFavoritesParams(
          page: page,
          sort: sort,
          key: key,
          accessToken: await storage.read(key: 'accessToken') ?? ''),
    );

    failureOrFavorite.fold(
      (Failure newFailure) {
        _isLoading = false;

        favoriteList = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<WordEntity>> newFavorites) {
        _isLoading = false;
        favoriteList = newFavorites.data;

        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrToggleFavorite(int wordId) async {
    _isLoading = true;
    FavoriteRepositoryImpl repository = FavoriteRepositoryImpl(
      remoteDataSource: FavoriteRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrFavorite =
        await ToggleFavoriteUsecase(favoriteRepository: repository).call(
            toggleFavoriteParams: ToggleFavoriteParams(
                wordId: wordId,
                accessToken: await storage.read(key: 'accessToken') ?? ''));

    failureOrFavorite.fold(
      (Failure newFailure) {
        _isLoading = false;
        favoriteEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<FavoriteEntity> newFavorite) {
        _isLoading = false;
        favoriteEntity = newFavorite.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrIsFavorite(int wordId) async {
    _isLoading = true;
    FavoriteRepositoryImpl repository = FavoriteRepositoryImpl(
      remoteDataSource: FavoriteRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrFavorite =
        await CheckFavoriteUsecase(favoriteRepository: repository).call(
            checkFavoriteParams: CheckFavoriteParams(
                wordId: wordId,
                accessToken: await storage.read(key: 'accessToken') ?? ''));

    failureOrFavorite.fold(
      (Failure newFailure) {
        _isLoading = false;
        isFavorite = false;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<bool> newFavorite) {
        _isLoading = false;
        isFavorite = newFavorite.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
