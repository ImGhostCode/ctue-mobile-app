import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';
import 'package:ctue_app/features/sentence/data/models/sentence_model.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';

class FavoriteModel extends FavoriteEntity {
  FavoriteModel(
      {required super.id,
      required super.userId,
      super.word,
      super.sentence,
      super.wordId,
      super.sentenceId});

  factory FavoriteModel.fromJson({required Map<String, dynamic> json}) {
    return FavoriteModel(
        id: json[kId],
        userId: json[kUserId],
        wordId: json[kWordId],
        sentenceId: json[kSentenceId],
        word:
            json[kWord] != null ? WordModel.fromJson(json: json[kWord]) : null,
        sentence: json[kSentence] != null
            ? SentenceModel.fromJson(json: json[kSentence])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kUserId: userId,
      kWordId: wordId,
      kSentenceId: sentenceId,
      kWord: word != null ? (word as WordModel).toJson() : null,
      kSentence: sentence != null ? (sentence as SentenceModel).toJson() : null
    };
  }
}
