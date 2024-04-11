import 'package:ctue_app/features/statistics/business/entities/statistics_sub_entity.dart';

import '../../../../../core/constants/constants.dart';

class SpecStatisticsModel extends SpecStatisticsEntity {
  SpecStatisticsModel(
      {required super.count, required super.specializationName});

  factory SpecStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return SpecStatisticsModel(
      specializationName: json[kSpecializationName],
      count: json[kCount],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kSpecializationName: specializationName,
      kCount: count,
    };
  }
}

class LevelStatisticsModel extends LevelStatisticsEntity {
  LevelStatisticsModel({required super.count, required super.levelName});

  factory LevelStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return LevelStatisticsModel(
      levelName: json[kLevelName],
      count: json[kCount],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kLevelName: levelName,
      kCount: count,
    };
  }
}

class TopicStatisticsModel extends TopicStatisticsEntity {
  TopicStatisticsModel({required super.count, required super.topicName});

  factory TopicStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return TopicStatisticsModel(
      topicName: json[kTopicName],
      count: json[kCount],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTopicName: topicName,
      kCount: count,
    };
  }
}

class TypeStatisticsModel extends TypeStatisticsEntity {
  TypeStatisticsModel({required super.count, required super.typeName});

  factory TypeStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return TypeStatisticsModel(
      typeName: json[kTypeName],
      count: json[kCount],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTypeName: typeName,
      kCount: count,
    };
  }
}
