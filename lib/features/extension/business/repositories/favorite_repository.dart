import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, ResponseDataModel<FavoriteResEntity>>>
      getFavoriteList({
    required GetFavoritesParams getFavoritesParams,
  });
  Future<Either<Failure, ResponseDataModel<FavoriteEntity>>> toggleFavorite({
    required ToggleFavoriteParams toggleFavoriteParams,
  });
  Future<Either<Failure, ResponseDataModel<bool>>> checkIsFavorite({
    required CheckFavoriteParams checkFavoriteParams,
  });
}
