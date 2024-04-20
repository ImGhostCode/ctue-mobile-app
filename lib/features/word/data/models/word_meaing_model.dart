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
        typeId: json[kTypeId],
        wordId: json[kWordId],
        meaning: json[kMeaning],
        type:
            json[kTYPE] != null ? TypeModel.fromJson(json: json[kTYPE]) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      kTypeId: typeId,
      kWordId: wordId,
      kMeaning: meaning,
      // kTYPE: TypeModel(id: type!.id, name: type!.name, isWord: type!.isWord)
      //     .toJson()
      kTYPE: (type as TypeModel?)?.toJson()
    };
  }
}
