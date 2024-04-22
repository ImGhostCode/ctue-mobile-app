import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/level_params.dart';
import 'package:ctue_app/features/level/data/models/level_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class LevelRemoteDataSource {
  Future<ResponseDataModel<List<LevelModel>>> getLevels(
      {required LevelParams levelParams});
}

class LevelRemoteDataSourceImpl implements LevelRemoteDataSource {
  final Dio dio;

  LevelRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<List<LevelModel>>> getLevels(
      {required LevelParams levelParams}) async {
    try {
      final response = await dio.get('/levels',
          queryParameters: {
            'api_key': 'if needed',
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));
      return ResponseDataModel<List<LevelModel>>.fromJson(
          json: response.data,
          fromJsonD: (jsonLevels) => jsonLevels['results']
              ?.map<LevelModel>((json) => LevelModel.fromJson(json: json))
              .toList());
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
