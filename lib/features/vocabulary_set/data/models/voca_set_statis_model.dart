import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_statistics_entity.dart';

class VocaSetStatisticsModel extends VocaSetStatisticsEntity {
  VocaSetStatisticsModel(
      {required super.numberOfWords, required super.detailVocaSetStatisEntity});

  factory VocaSetStatisticsModel.fromJson(
      {required Map<String, dynamic> json}) {
    return VocaSetStatisticsModel(
        numberOfWords: json[kNumberOfWords],
        detailVocaSetStatisEntity:
            DetailVocaSetStatisModel.fromJson(json: json[kDetail]));
  }

  Map<String, dynamic> toJson() {
    return {
      kNumberOfWords: numberOfWords,
      kDetail: detailVocaSetStatisEntity,
    };
  }
}

class DetailVocaSetStatisModel extends DetailVocaSetStatisEntity {
  DetailVocaSetStatisModel({
    super.level_1,
    super.level_2,
    super.level_3,
    super.level_4,
    super.level_5,
    super.level_6,
  });

  factory DetailVocaSetStatisModel.fromJson(
      {required Map<String, dynamic> json}) {
    return DetailVocaSetStatisModel(
      level_1: json[kLevel_1] != null
          ? json[kLevel_1]
              .map<UserLearnedWordModel>(
                  (set) => UserLearnedWordModel.fromJson(json: set))
              .toList()
          : [],
      level_2: json[kLevel_2] != null
          ? json[kLevel_2]
              .map<UserLearnedWordModel>(
                  (set) => UserLearnedWordModel.fromJson(json: set))
              .toList()
          : [],
      level_3: json[kLevel_3] != null
          ? json[kLevel_3]
              .map<UserLearnedWordModel>(
                  (set) => UserLearnedWordModel.fromJson(json: set))
              .toList()
          : [],
      level_4: json[kLevel_4] != null
          ? json[kLevel_4]
              .map<UserLearnedWordModel>(
                  (set) => UserLearnedWordModel.fromJson(json: set))
              .toList()
          : [],
      level_5: json[kLevel_5] != null
          ? json[kLevel_5]
              .map<UserLearnedWordModel>(
                  (set) => UserLearnedWordModel.fromJson(json: set))
              .toList()
          : [],
      level_6: json[kLevel_6] != null
          ? json[kLevel_6]
              .map<UserLearnedWordModel>(
                  (set) => UserLearnedWordModel.fromJson(json: set))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kLevel_1: level_1,
      kLevel_2: level_2,
      kLevel_3: level_3,
      kLevel_4: level_4,
      kLevel_5: level_5,
      kLevel_6: level_6,
    };
  }
}
