import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class UserLearnedWordEntity {
  final int userId;
  final int wordId;
  final int vocabularySetId;
  final int memoryLevel;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserEntity? user;
  final WordEntity word;

  UserLearnedWordEntity({
    required this.userId,
    required this.wordId,
    required this.vocabularySetId,
    required this.memoryLevel,
    required this.word,
    this.createdAt,
    this.updatedAt,
    this.user,
  });
}
