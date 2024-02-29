import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';
import 'package:ctue_app/features/extension/business/repositories/favorite_repository.dart';
import 'package:dartz/dartz.dart';

class ToggleFavoriteUsecase {
  final FavoriteRepository favoriteRepository;

  ToggleFavoriteUsecase({required this.favoriteRepository});

  Future<Either<Failure, ResponseDataModel<FavoriteEntity>>> call({
    required ToggleFavoriteParams toggleFavoriteParams,
  }) async {
    return await favoriteRepository.toggleFavorite(
        toggleFavoriteParams: toggleFavoriteParams);
  }
}
