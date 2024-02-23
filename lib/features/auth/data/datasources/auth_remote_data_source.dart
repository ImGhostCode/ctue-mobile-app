import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/params/params.dart';
import '../models/access_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseDataModel<AccessTokenModel>> login(
      {required LoginParams loginParams});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<AccessTokenModel>> login(
      {required LoginParams loginParams}) async {
    try {
      final response = await dio.post(
        '/auth/login',
        queryParameters: {
          'api_key': 'if needed',
        },
        data: {
          'email': loginParams.email,
          'password': loginParams.password,
        },
      );

      print('response $response');

      // if (response.data['statusCode'] == 200) {
      return ResponseDataModel<AccessTokenModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => AccessTokenModel.fromJson(json: json));
      // } else {
      //   throw ServerException(
      //       statusCode: response.statusCode!,
      //       errorMessage: response.statusMessage!);
      // }
    } on DioException catch (e) {
      throw ServerException(
          statusCode: e.response!.statusCode!,
          errorMessage: e.response!.data['message'] ?? 'Unknown server error');
    }
  }
}
