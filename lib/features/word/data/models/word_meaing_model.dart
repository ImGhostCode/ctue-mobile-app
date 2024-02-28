import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/type/data/models/type_model.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class WordMeaningModel extends WordMeaningEntity {
  WordMeaningModel(
      {required super.typeId,
      required super.wordId,
      required super.meaning,
      super.type});

  factory WordMeaningModel.fromJson({required Map<String, dynamic> json}) {
    return WordMeaningModel(
        typeId: json['typeId'],
        wordId: json['wordId'],
        meaning: json['meaning'],
        type: json['Type'] != null
            ? TypeModel.fromJson(json: json['Type'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      kTypeId: typeId,
      kWordId: wordId,
      kMeaning: meaning,
      kType: TypeModel(id: type!.id, name: type!.name, isWord: type!.isWord)
          .toJson()
    };
  }
}
