import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:ctue_app/features/user/data/models/user_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/params/params.dart';

abstract class UserRemoteDataSource {
  Future<ResponseDataModel<UserModel>> getUser(
      {required GetUserParams getUserParams});
  Future<ResponseDataModel<UserResModel>> getAllUser(
      {required GetAllUserParams getAllUserParams});

  Future<ResponseDataModel<UserModel>> updateUser(
      {required UpdateUserParams updateUserParams});
  Future<ResponseDataModel<void>> resetPassword(
      {required ResetPasswordParams resetPasswordParams});
  Future<ResponseDataModel<void>> getVerifyCode(
      {required GetVerifyCodeParams getVerifyCodeParams});
  Future<ResponseDataModel<void>> toggleBanUser(
      {required ToggleBanUserParams toggleBanUserParams});
  Future<ResponseDataModel<void>> deleteUser(
      {required DeleteUserParams deleteUserParams});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

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
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(
            statusCode: 500, errorMessage: 'Can\'t connect server');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response?.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<UserModel>> updateUser(
      {required UpdateUserParams updateUserParams}) async {
    try {
      final formData = FormData.fromMap({
        'name': updateUserParams.name ?? "",
        'avt': updateUserParams.avt != null
            ? MultipartFile.fromFileSync(updateUserParams.avt!.path,
                filename: updateUserParams.avt!.name)
            : '',
        if (updateUserParams.interestTopics != null)
          'interestTopics': updateUserParams.interestTopics!.length > 1
              ? updateUserParams.interestTopics
              : [updateUserParams.interestTopics]
      });
      final response = await dio.patch('/users/${updateUserParams.id}',
          queryParameters: {
            'api_key': 'if needed',
          },
          data: formData,
          options: Options(headers: {
            "authorization": "Bearer ${updateUserParams.accessToken}"
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

  @override
  Future<ResponseDataModel<void>> resetPassword(
      {required ResetPasswordParams resetPasswordParams}) async {
    try {
      final response = await dio.patch('/users/reset/password',
          queryParameters: {
            'api_key': 'if needed',
          },
          data: {
            'code': resetPasswordParams.code,
            'email': resetPasswordParams.email,
            'newPassword': resetPasswordParams.newPassword
          },
          options: Options(headers: {
            // "authorization": "Bearer ${resetPasswordParams.accessToken}"
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

  @override
  Future<ResponseDataModel<void>> getVerifyCode(
      {required GetVerifyCodeParams getVerifyCodeParams}) async {
    try {
      final response = await dio.post('/users/verify-code',
          queryParameters: {
            'api_key': 'if needed',
          },
          data: {
            'email': getVerifyCodeParams.email,
          },
          options: Options(headers: {
            // "authorization": "Bearer ${resetPasswordParams.accessToken}"
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

  @override
  Future<ResponseDataModel<UserResModel>> getAllUser(
      {required GetAllUserParams getAllUserParams}) async {
    try {
      final response = await dio.get('/users',
          queryParameters: {
            'page': getAllUserParams.page,
          },
          options: Options(headers: {
            "authorization": "Bearer ${getAllUserParams.accessToken}"
          }));
      return ResponseDataModel<UserResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => UserResModel.fromJson(json: json));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(
            statusCode: 500, errorMessage: 'Can\'t connect server');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response?.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<void>> toggleBanUser(
      {required ToggleBanUserParams toggleBanUserParams}) async {
    try {
      final response = await dio.patch(
          '/users/toggle-ban/${toggleBanUserParams.userId}',
          data: {'feedback': toggleBanUserParams.feedback},
          options: Options(headers: {
            "authorization": "Bearer ${toggleBanUserParams.accessToken}"
          }));
      return ResponseDataModel<void>.fromJson(
          json: response.data, fromJsonD: (json) {});
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(
            statusCode: 500, errorMessage: 'Can\'t connect server');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response?.data['message'] ?? 'Unknown server error');
      }
    }
  }

  @override
  Future<ResponseDataModel<void>> deleteUser(
      {required DeleteUserParams deleteUserParams}) async {
    try {
      final response = await dio.delete('/users/${deleteUserParams.userId}',
          options: Options(headers: {
            "authorization": "Bearer ${deleteUserParams.accessToken}"
          }));
      return ResponseDataModel<void>.fromJson(
          json: response.data, fromJsonD: (json) {});
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.cancel) {
        throw ServerException(
            statusCode: 400, errorMessage: 'Connection Refused');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(
            statusCode: 500, errorMessage: 'Can\'t connect server');
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response?.data['message'] ?? 'Unknown server error');
      }
    }
  }
}
