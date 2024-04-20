import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class TopicLocalDataSource {
  Future<void> cacheTopic(
      {required ResponseDataModel<List<TopicModel>>? topicModel});
  Future<ResponseDataModel<List<TopicModel>>> getLastTopic();
}

const cachedTopic = 'CACHED_TOPIC';

class TopicLocalDataSourceImpl implements TopicLocalDataSource {
  final SharedPreferences sharedPreferences;

  TopicLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<List<TopicModel>>> getLastTopic() {
    final jsonString = sharedPreferences.getString(cachedTopic);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<TopicModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (item) => item
              ?.map<TopicModel>((json) => TopicModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTopic(
      {required ResponseDataModel<List<TopicModel>>? topicModel}) async {
    if (topicModel != null) {
      sharedPreferences.setString(
        cachedTopic,
        json.encode(Map.from({
          "data": topicModel.data.map((e) => e.toJson()).toList(),
          "statusCode": topicModel.statusCode,
          "message": topicModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }
}
