import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/data/models/favorite_model.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class FavoriteRemoteDataSource {
  Future<ResponseDataModel<List<WordModel>>> getFavorites(
      {required GetFavoritesParams getFavoritesParams});
  Future<ResponseDataModel<FavoriteModel>> toggleFavorite(
      {required ToggleFavoriteParams toggleFavoriteParams});
  Future<ResponseDataModel<bool>> checkIsFavorite(
      {required CheckFavoriteParams checkFavoriteParams});
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final Dio dio;

  FavoriteRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<FavoriteModel>> toggleFavorite(
      {required ToggleFavoriteParams toggleFavoriteParams}) async {
    try {
      final response = await dio.patch('/favorite/user',
          queryParameters: {},
          data: {'wordId': toggleFavoriteParams.wordId},
          options: Options(headers: {
            "authorization": "Bearer ${toggleFavoriteParams.accessToken}"
          }));

      return ResponseDataModel<FavoriteModel>.fromJson(
        json: response.data,
        fromJsonD: (jsonFavorite) => FavoriteModel.fromJson(json: jsonFavorite),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<List<WordModel>>> getFavorites(
      {required GetFavoritesParams getFavoritesParams}) async {
    try {
      final response = await dio.get('/favorite/user',
          queryParameters: {
            'page': getFavoritesParams.page,
            'sort': getFavoritesParams.sort,
            'key': getFavoritesParams.key,
          },
          options: Options(headers: {
            "authorization": "Bearer ${getFavoritesParams.accessToken}"
          }));

      return ResponseDataModel<List<WordModel>>.fromJson(
        json: response.data,
        fromJsonD: (jsonFavorites) => jsonFavorites['results']['Word']
            ?.map<WordModel>((json) => WordModel.fromJson(json: json))
            .toList(),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<bool>> checkIsFavorite(
      {required CheckFavoriteParams checkFavoriteParams}) async {
    try {
      final response = await dio.get(
          '/favorite/user/is-favorite/${checkFavoriteParams.wordId}',
          queryParameters: {},
          options: Options(headers: {
            "authorization": "Bearer ${checkFavoriteParams.accessToken}"
          }));

      return ResponseDataModel<bool>.fromJson(
        json: response.data,
        fromJsonD: (jsonFavorites) => jsonFavorites['result'],
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
      }
    }
  }
}
