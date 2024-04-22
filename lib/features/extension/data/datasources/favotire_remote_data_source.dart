import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/favorite_params.dart';
import 'package:ctue_app/features/extension/data/models/favorite_model.dart';
import 'package:ctue_app/features/extension/data/models/favorite_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class FavoriteRemoteDataSource {
  Future<ResponseDataModel<FavoriteResModel>> getFavorites(
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
      final response = await dio.patch('/favorites/user',
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
  Future<ResponseDataModel<FavoriteResModel>> getFavorites(
      {required GetFavoritesParams getFavoritesParams}) async {
    try {
      final response = await dio.get('/favorites/user',
          queryParameters: {
            'page': getFavoritesParams.page,
            'sort': getFavoritesParams.sort,
            'key': getFavoritesParams.key,
          },
          options: Options(headers: {
            "authorization": "Bearer ${getFavoritesParams.accessToken}"
          }));

      return ResponseDataModel<FavoriteResModel>.fromJson(
        json: response.data,
        fromJsonD: (jsonFavorites) =>
            FavoriteResModel.fromJson(json: jsonFavorites),
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
          '/favorites/user/is-favorite/${checkFavoriteParams.wordId}',
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
