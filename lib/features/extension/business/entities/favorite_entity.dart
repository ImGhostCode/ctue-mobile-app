import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class FavoriteEntity {
  final int id;
  final int userId;
  final int? wordId;
  final int? sentenceId;
  final WordEntity? word;
  final SentenceEntity? sentence;

  FavoriteEntity(
      {required this.id,
      required this.userId,
      this.wordId,
      this.sentenceId,
      this.word,
      this.sentence});
}
