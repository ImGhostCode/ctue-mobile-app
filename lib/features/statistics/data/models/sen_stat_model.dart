import 'package:ctue_app/features/statistics/business/entities/sen_stat_entity.dart';
import 'package:ctue_app/features/statistics/data/models/statistics_sub_model.dart';

import '../../../../../core/constants/constants.dart';

class SenStatisticsModel extends SenStatisticsEntity {
  const SenStatisticsModel(
      {required super.total, required super.byType, required super.byTopic});

  factory SenStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return SenStatisticsModel(
      total: json[kTotal],
      byType: json[kByType]
          .map<TypeStatisticsModel>(
              (item) => TypeStatisticsModel.fromJson(json: item))
          .toList(),
      byTopic: json[kByTopic]
          .map<TopicStatisticsModel>(
              (item) => TopicStatisticsModel.fromJson(json: item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kByType: byType,
      kByTopic: byTopic,
    };
  }
}
