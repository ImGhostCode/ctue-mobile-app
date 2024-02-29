class GetFavoritesParams {
  final int? page;
  final String? sort;
  final String? key;
  final String accessToken;
  GetFavoritesParams(
      {this.page, this.key, this.sort, required this.accessToken});
}

class ToggleFavoriteParams {
  final int wordId;
  final String accessToken;

  ToggleFavoriteParams({required this.wordId, required this.accessToken});
}

class CheckFavoriteParams {
  final int wordId;
  final String accessToken;

  CheckFavoriteParams({required this.wordId, required this.accessToken});
}
