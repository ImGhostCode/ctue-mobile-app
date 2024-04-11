class SpecStatisticsEntity {
  final String specializationName;
  final int count;

  SpecStatisticsEntity({required this.count, required this.specializationName});
}

class LevelStatisticsEntity {
  final String levelName;
  final int count;

  LevelStatisticsEntity({required this.count, required this.levelName});
}

class TopicStatisticsEntity {
  final String topicName;
  final int count;

  TopicStatisticsEntity({required this.count, required this.topicName});
}

class TypeStatisticsEntity {
  final String typeName;
  final int count;

  TypeStatisticsEntity({required this.count, required this.typeName});
}
