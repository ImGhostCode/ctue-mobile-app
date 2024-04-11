import 'package:ctue_app/features/statistics/business/entities/statistics_sub_entity.dart';

class VocaSetStatisticsEntity {
  final int total;
  final int totalPublic;
  final int totalPrivate;
  final List<SpecStatisticsEntity> bySpecialization;
  final List<TopicStatisticsEntity> byTopic;
  const VocaSetStatisticsEntity(
      {required this.total,
      required this.totalPrivate,
      required this.totalPublic,
      required this.bySpecialization,
      required this.byTopic});
}
