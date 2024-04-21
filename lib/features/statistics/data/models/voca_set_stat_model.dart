import 'package:ctue_app/features/statistics/business/entities/voca_set_stat_entity.dart';
import 'package:ctue_app/features/statistics/data/models/statistics_sub_model.dart';

import '../../../../../core/constants/constants.dart';

class VocaSetStatisticsModel extends VocaSetStatisticsEntity {
  VocaSetStatisticsModel(
      {required super.total,
      required super.bySpecialization,
      required super.byTopic,
      required super.totalPrivate,
      required super.totalPublic});

  factory VocaSetStatisticsModel.fromJson(
      {required Map<String, dynamic> json}) {
    return VocaSetStatisticsModel(
      total: json[kTotal],
      totalPrivate: json[kTotalPublic],
      totalPublic: json[kTotalPrivate],
      bySpecialization: json[kBySpecialization]
          .map<SpecStatisticsModel>(
              (item) => SpecStatisticsModel.fromJson(json: item))
          .toList() as List<SpecStatisticsModel>,
      byTopic: json[kByTopic]
          .map<TopicStatisticsModel>(
              (item) => TopicStatisticsModel.fromJson(json: item))
          .toList() as List<TopicStatisticsModel>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kTotalPublic: totalPublic,
      kTotalPrivate: totalPrivate,
      kBySpecialization:
          (bySpecialization as List<dynamic>).map((e) => e.toJson()).toList(),
      kByTopic: (byTopic as List<dynamic>).map((e) => e.toJson()).toList(),
    };
  }
}
