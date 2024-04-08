import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/notification_params.dart';
import 'package:ctue_app/features/notification/data/models/noti_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class NotiRemoteDataSource {
  Future<ResponseDataModel<NotiResModel>> getAllUserNoti(
      {required GetAllUserNotiParams getAllUserNotiParams});
}

class NotiRemoteDataSourceImpl implements NotiRemoteDataSource {
  final Dio dio;

  NotiRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<NotiResModel>> getAllUserNoti(
      {required GetAllUserNotiParams getAllUserNotiParams}) async {
    try {
      final response = await dio.get('/notification/user',
          queryParameters: {
            'page': getAllUserNotiParams.page,
          },
          options: Options(headers: {
            "authorization": "Bearer ${getAllUserNotiParams.accessToken}"
          }));
      return ResponseDataModel<NotiResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => NotiResModel.fromJson(json: json));
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
