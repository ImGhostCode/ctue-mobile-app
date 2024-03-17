import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_model.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_statis_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class LearnRemoteDataSource {
//   Future<ResponseDataModel<LearnStatisticsModel>> getLearnStatistics(
//       {required GetLearnStatisParams getLearnStatisParams});
}

class LearnRemoteDataSourceImpl implements LearnRemoteDataSource {
  final Dio dio;

  LearnRemoteDataSourceImpl({required this.dio});

  // @override
  // Future<ResponseDataModel<VocaSetStatisticsModel>> getVocaSetStatistics(
  //     {required GetVocaSetStatisParams getVocaSetStatisParams}) async {
  //   try {
  //     final response = await dio.get('/learn/statistics',
  //         queryParameters: {"setId": getVocaSetStatisParams.id},
  //         options: Options(headers: {
  //           "authorization": "Bearer ${getVocaSetStatisParams.accessToken}"
  //         }));
  //     return ResponseDataModel<VocaSetStatisticsModel>.fromJson(
  //         json: response.data,
  //         fromJsonD: (json) => VocaSetStatisticsModel.fromJson(json: json));
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionError ||
  //         e.type == DioExceptionType.cancel) {
  //       throw ServerException(
  //           statusCode: 400, errorMessage: 'Connection Refused');
  //     } else {
  //       throw ServerException(
  //           statusCode: e.response!.statusCode!,
  //           errorMessage:
  //               e.response!.data['message'] ?? 'Unknown server error');
  //     }
  //   }
  // }
}
