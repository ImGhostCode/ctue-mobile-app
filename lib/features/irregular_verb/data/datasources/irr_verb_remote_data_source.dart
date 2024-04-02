import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/irr_verb_params.dart';
import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class IrrVerbRemoteDataSource {
  Future<ResponseDataModel<IrrVerbResModel>> getIrrVerbs(
      {required IrrVerbParams irrVerbParams});
}

class IrrVerbRemoteDataSourceImpl implements IrrVerbRemoteDataSource {
  final Dio dio;

  IrrVerbRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<IrrVerbResModel>> getIrrVerbs(
      {required IrrVerbParams irrVerbParams}) async {
    try {
      final response = await dio.get('/irregular-verb/',
          queryParameters: {
            "page": irrVerbParams.page,
            "sort": irrVerbParams.sort,
            "key": irrVerbParams.key
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<IrrVerbResModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => IrrVerbResModel.fromJson(json: json));
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
