import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/user_params.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/params/params.dart';

abstract class UserRemoteDataSource {
  Future<ResponseDataModel<UserModel>> getUser(
      {required GetUserParams getUserParams});

  Future<ResponseDataModel<UserModel>> updateUser(
      {required UpdateUserParams updateUserParams});
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
      } else {
        throw ServerException(
            statusCode: e.response!.statusCode!,
            errorMessage:
                e.response!.data['message'] ?? 'Unknown server error');
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
            : ''
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
}
