import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class TopicRemoteDataSource {
  Future<ResponseDataModel<List<TopicModel>>> getTopics(
      {required TopicParams topicParams});
}

class TopicRemoteDataSourceImpl implements TopicRemoteDataSource {
  final Dio dio;

  TopicRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDataModel<List<TopicModel>>> getTopics(
      {required TopicParams topicParams}) async {
    try {
      final response = await dio.get('/topics',
          queryParameters: {
            'isWord': topicParams.isWord,
          },
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return ResponseDataModel<List<TopicModel>>.fromJson(
        json: response.data,
        fromJsonD: (jsonTopics) => jsonTopics
            ?.map<TopicModel>((json) => TopicModel.fromJson(json: json))
            .toList(),
      );
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
