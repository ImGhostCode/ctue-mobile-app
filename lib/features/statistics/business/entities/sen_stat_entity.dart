import 'package:ctue_app/features/statistics/business/entities/statistics_sub_entity.dart';

class SenStatisticsEntity {
  final int total;

  final List<TypeStatisticsEntity> byType;
  final List<TopicStatisticsEntity> byTopic;
  const SenStatisticsEntity(
      {required this.total, required this.byType, required this.byTopic});
}
