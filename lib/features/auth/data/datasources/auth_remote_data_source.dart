import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/auth_params.dart';
import 'package:ctue_app/features/auth/data/models/account_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/params/params.dart';
import '../models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseDataModel<LoginModel>> login(
      {required LoginParams loginParams});
  Future<ResponseDataModel<void>> logout({required LogoutParams logoutParams});
  Future<ResponseDataModel<AccountModel>> signup(
      {required SignupParams signupParams});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<LoginModel>> login(
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
          'fcmToken': loginParams.fcmToken
        },
      );

      // Handle successful response by returning the parsed ResponseDataModel
      return ResponseDataModel<LoginModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => LoginModel.fromJson(json: json));
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
          if (signupParams.interestTopics != null)
            'interestTopics': signupParams.interestTopics!.length > 1
                ? signupParams.interestTopics
                : [signupParams.interestTopics]
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
  Future<ResponseDataModel<void>> logout(
      {required LogoutParams logoutParams}) async {
    try {
      final response = await dio.post('/auth/logout',
          queryParameters: {
            'api_key': 'if needed',
          },
          data: {},
          options: Options(headers: {
            "authorization": "Bearer ${logoutParams.accessToken}"
          }));
      return ResponseDataModel<void>.fromJson(
          json: response.data, fromJsonD: (json) => json);
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
