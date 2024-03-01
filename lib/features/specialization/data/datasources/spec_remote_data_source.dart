import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/specialization_params.dart';
import 'package:ctue_app/features/specialization/data/models/specialization_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class SpecRemoteDataSource {
  Future<ResponseDataModel<List<SpecializationModel>>> getSpecializations(
      {required SpecializationParams specializationParams});
}

class SpecRemoteDataSourceImpl implements SpecRemoteDataSource {
  final Dio dio;

  SpecRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<List<SpecializationModel>>> getSpecializations(
      {required SpecializationParams specializationParams}) async {
    try {
      final response = await dio.get('/specialization',
          queryParameters: {
            'api_key': 'if needed',
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));
      return ResponseDataModel<List<SpecializationModel>>.fromJson(
          json: response.data,
          fromJsonD: (jsonSpecializations) => jsonSpecializations['results']
              ?.map<SpecializationModel>(
                  (json) => SpecializationModel.fromJson(json: json))
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
