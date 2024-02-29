import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/business/repositories/favorite_repository.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:dartz/dartz.dart';

class GetFavoriteUsecase {
  final FavoriteRepository favoriteRepository;

  GetFavoriteUsecase({required this.favoriteRepository});

  Future<Either<Failure, ResponseDataModel<List<WordEntity>>>> call({
    required GetFavoritesParams getFavoritesParams,
  }) async {
    return await favoriteRepository.getFavoriteList(
        getFavoritesParams: getFavoritesParams);
  }
}
