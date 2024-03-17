import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';

class UserLearnedWordModel extends UserLearnedWordEntity {
  UserLearnedWordModel(
      {required super.userId,
      required super.wordId,
      required super.vocabularySetId,
      required super.memoryLevel,
      required super.word});

  factory UserLearnedWordModel.fromJson({required Map<String, dynamic> json}) {
    return UserLearnedWordModel(
        userId: json[kUserId],
        wordId: json[kWordId],
        vocabularySetId: json[kVocaSetId],
        memoryLevel: json[kMemoryLevel],
        word: WordModel.fromJson(json: json[kWord]));
  }

  Map<String, dynamic> toJson() {
    return {
      kUserId: userId,
      kWordId: wordId,
      kVocaSetId: vocabularySetId,
      kMemoryLevel: memoryLevel,
      kWord: word,
    };
  }
}
