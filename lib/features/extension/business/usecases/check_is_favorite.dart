import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/business/repositories/favorite_repository.dart';
import 'package:dartz/dartz.dart';

class CheckFavoriteUsecase {
  final FavoriteRepository favoriteRepository;

  CheckFavoriteUsecase({required this.favoriteRepository});

  Future<Either<Failure, ResponseDataModel<bool>>> call({
    required CheckFavoriteParams checkFavoriteParams,
  }) async {
    return await favoriteRepository.checkIsFavorite(
        checkFavoriteParams: checkFavoriteParams);
  }
}
