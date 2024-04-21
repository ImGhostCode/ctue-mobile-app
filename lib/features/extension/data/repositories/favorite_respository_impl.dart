import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';
import 'package:ctue_app/features/extension/business/repositories/favorite_repository.dart';
import 'package:ctue_app/features/extension/data/datasources/favorite_local_data_source.dart';
import 'package:ctue_app/features/extension/data/datasources/favotire_remote_data_source.dart';
import 'package:ctue_app/features/extension/data/models/favorite_model.dart';

import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;
  final FavoriteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FavoriteRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<WordModel>>>> getFavoriteList(
      {required GetFavoritesParams getFavoritesParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<WordModel>> remoteFavorite =
            await remoteDataSource.getFavorites(
                getFavoritesParams: getFavoritesParams);

        localDataSource.cacheFavorite(favoriteModel: remoteFavorite);

        return Right(remoteFavorite);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<WordModel>> localFavorites =
            await localDataSource.getLastFavorites();
        return Right(localFavorites);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<FavoriteEntity>>> toggleFavorite(
      {required ToggleFavoriteParams toggleFavoriteParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<FavoriteModel> remoteFavorite = await remoteDataSource
            .toggleFavorite(toggleFavoriteParams: toggleFavoriteParams);

        // localDataSource.cacheFavorite(templateToCache: remoteFavorite);

        return Right(remoteFavorite);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<bool>>> checkIsFavorite(
      {required CheckFavoriteParams checkFavoriteParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<bool> remoteFavorite = await remoteDataSource
            .checkIsFavorite(checkFavoriteParams: checkFavoriteParams);

        // localDataSource.cacheFavorite(templateToCache: remoteFavorite);

        return Right(remoteFavorite);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }
}
