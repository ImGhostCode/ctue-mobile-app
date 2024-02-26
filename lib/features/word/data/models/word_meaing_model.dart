import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class WordMeaningModel extends WordMeaningEntity {
  WordMeaningModel(
      {required super.typeId, required super.wordId, required super.meaning});

  factory WordMeaningModel.fromJson({required Map<String, dynamic> json}) {
    return WordMeaningModel(
      typeId: json['typeId'],
      wordId: json['wordId'],
      meaning: json['meaning'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTypeId: typeId,
      kWordId: wordId,
      kMeaning: meaning,
    };
  }
}
