import 'package:ctue_app/features/statistics/business/entities/word_stat_entity.dart';
import 'package:ctue_app/features/statistics/data/models/statistics_sub_model.dart';

import '../../../../../core/constants/constants.dart';

class WordStatisticsModel extends WordStatisticsEntity {
  const WordStatisticsModel(
      {required super.total,
      required super.bySpecialization,
      required super.byLevel,
      required super.byTopic});

  factory WordStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return WordStatisticsModel(
      total: json[kTotal],
      bySpecialization: json[kBySpecialization]
          .map<SpecStatisticsModel>(
              (item) => SpecStatisticsModel.fromJson(json: item))
          .toList(),
      byLevel: json[kByLevel]
          .map<LevelStatisticsModel>(
              (item) => LevelStatisticsModel.fromJson(json: item))
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
      kBySpecialization: bySpecialization,
      kByLevel: byLevel,
      kByTopic: byTopic,
    };
  }
}
