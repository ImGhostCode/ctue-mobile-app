import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';

class UserLearnedWordModel extends UserLearnedWordEntity {
  UserLearnedWordModel(
      {required super.userId,
      required super.wordId,
      required super.vocabularySetId,
      required super.memoryLevel,
      super.createdAt,
      super.updatedAt,
      super.user,
      super.word});

  factory UserLearnedWordModel.fromJson({required Map<String, dynamic> json}) {
    return UserLearnedWordModel(
        userId: json[kUserId],
        wordId: json[kWordId],
        vocabularySetId: json[kVocaSetId],
        memoryLevel: json[kMemoryLevel],
        createdAt:
            json[kCreatedAt] != null ? DateTime.parse(json[kCreatedAt]) : null,
        updatedAt:
            json[kUpdatedAt] != null ? DateTime.parse(json[kUpdatedAt]) : null,
        word:
            json[kWord] != null ? WordModel.fromJson(json: json[kWord]) : null,
        user:
            json[kUser] != null ? UserModel.fromJson(json: json[kUser]) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      kUserId: userId,
      kWordId: wordId,
      kVocaSetId: vocabularySetId,
      kCreatedAt: createdAt.toString(),
      kUpdatedAt: updatedAt.toString(),
      kMemoryLevel: memoryLevel,
      kWord: (word as WordModel?)?.toJson(),
      kUser: (user as UserModel?)?.toJson()
    };
  }
}
