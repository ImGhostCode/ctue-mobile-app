import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/data/models/type_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/template_model.dart';

abstract class TypeRemoteDataSource {
  Future<ResponseDataModel<TypeModel>> getTypes(
      {required TypeParams typeParams});
}

class TypeRemoteDataSourceImpl implements TypeRemoteDataSource {
  final Dio dio;

  TypeRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<TypeModel>> getTypes(
      {required TypeParams typeParams}) async {
    try {
      final response = await dio.get('/type/${typeParams.isWord}',
          queryParameters: {
            'api_key': 'if needed',
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));
      return ResponseDataModel<TypeModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => TypeModel.fromJson(json: json));
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
