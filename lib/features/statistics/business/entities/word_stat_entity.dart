import 'package:ctue_app/features/statistics/business/entities/statistics_sub_entity.dart';

class WordStatisticsEntity {
  final int total;
  final List<SpecStatisticsEntity> bySpecialization;
  final List<LevelStatisticsEntity> byLevel;
  final List<TopicStatisticsEntity> byTopic;
  const WordStatisticsEntity(
      {required this.total,
      required this.bySpecialization,
      required this.byLevel,
      required this.byTopic});
}
