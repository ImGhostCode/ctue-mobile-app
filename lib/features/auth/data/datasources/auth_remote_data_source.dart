import 'dart:io';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/data/models/account_model.dart';
import 'package:ctue_app/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/params/params.dart';
import '../models/access_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseDataModel<AccessTokenModel>> login(
      {required LoginParams loginParams});
  Future<ResponseDataModel<AccountModel>> signup(
      {required SignupParams signupParams});
  Future<ResponseDataModel<UserModel>> getUser(
      {required GetUserParams getUserParams});
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
          'api_key': 'if needed', // Include necessary query parameters
        },
        data: {
          'email': loginParams.email,
          'password': loginParams.password,
        },
      );

      // Handle successful response by returning the parsed ResponseDataModel
      return ResponseDataModel<AccessTokenModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => AccessTokenModel.fromJson(json: json));
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
  Future<ResponseDataModel<AccountModel>> signup(
      {required SignupParams signupParams}) async {
    try {
      final response = await dio.post(
        '/auth/register',
        queryParameters: {
          'api_key': 'if needed',
        },
        data: {
          'name': signupParams.name,
          'email': signupParams.email,
          'password': signupParams.password,
        },
      );
      return ResponseDataModel<AccountModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => AccountModel.fromJson(json: json));
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
  Future<ResponseDataModel<UserModel>> getUser(
      {required GetUserParams getUserParams}) async {
    try {
      final response = await dio.get('/users/me',
          queryParameters: {
            'api_key': 'if needed',
          },
          options: Options(headers: {
            "authorization": "Bearer ${getUserParams.accessToken}"
          }));
      return ResponseDataModel<UserModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => UserModel.fromJson(json: json));
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
