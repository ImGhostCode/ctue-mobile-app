import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/type/data/models/type_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class TypeRemoteDataSource {
  Future<ResponseDataModel<List<TypeModel>>> getTypes(
      {required TypeParams typeParams});
}

class TypeRemoteDataSourceImpl implements TypeRemoteDataSource {
  final Dio dio;

  TypeRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<List<TypeModel>>> getTypes(
      {required TypeParams typeParams}) async {
    try {
      final response = await dio.get('/types/${typeParams.isWord}',
          queryParameters: {
            'api_key': 'if needed',
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));
      return ResponseDataModel<List<TypeModel>>.fromJson(
          json: response.data,
          fromJsonD: (jsonTypes) => jsonTypes['results']
              ?.map<TypeModel>((json) => TypeModel.fromJson(json: json))
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
