import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/speech/business/entities/prounc_statistics_entity.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';

class PronuncStatisticModel extends PronuncStatisticEntity {
  PronuncStatisticModel(
      {required super.avg,
      required super.detail,
      super.lablesNeedToBeImprove,
      super.lablesDoWell,
      super.suggestWordsToImprove});

  factory PronuncStatisticModel.fromJson({required Map<String, dynamic> json}) {
    return PronuncStatisticModel(
      avg: json[kAvg].toInt(),
      detail: json[kDetail]
          .map<DetailModel>((detail) => DetailModel.fromJson(json: detail))
          .toList(),
      lablesNeedToBeImprove: json[kLablesNeedToBeImprove]
          .map<DetailModel>((value) => DetailModel.fromJson(json: value))
          .toList(),
      lablesDoWell: json[kLablesDoWell]
          .map<DetailModel>((value) => DetailModel.fromJson(json: value))
          .toList(),
      suggestWordsToImprove: json[kSuggestWordsToImprove]
          .map<WordModel>((word) => WordModel.fromJson(json: word))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kAvg: avg,
      kDetail: detail,
    };
  }
}

class DetailModel extends DetailEntity {
  DetailModel({
    required super.avg,
    required super.label,
  });

  factory DetailModel.fromJson({required Map<String, dynamic> json}) {
    return DetailModel(
      avg: json[kavg].toInt(),
      label: json[kLabel],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kavg: avg,
      kLabel: label,
    };
  }
}
