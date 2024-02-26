import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/word/business/entities/level_entity.dart';
import 'package:ctue_app/features/word/business/entities/specialization_entity.dart';

class WordEntity {
  final int id;
  final int levelId;
  final int specializationId;
  final int? userId;
  final String content;
  final List<WordMeaningEntity> meanings;
  final String? note;
  final String? phonetic;
  final List<String> pictures;
  final List<String> examples;
  final List<String> synonyms;
  final List<String> antonyms;
  final bool isDeleted;
  final List<TopicEntity>? topics;
  final TypeEntity? typeEntity;
  final LevelEntity? levelEntity;
  final SpecializationEntity? specializationEntity;

  const WordEntity(
      {required this.id,
      required this.levelId,
      required this.specializationId,
      this.userId,
      required this.content,
      required this.meanings,
      required this.phonetic,
      required this.pictures,
      required this.examples,
      required this.synonyms,
      required this.antonyms,
      this.note,
      this.isDeleted = false,
      this.topics,
      this.typeEntity,
      this.levelEntity,
      this.specializationEntity});
}

class WordMeaningEntity {
  final int wordId;
  final int typeId;
  final String meaning;

  WordMeaningEntity(
      {required this.typeId, required this.wordId, required this.meaning});
}
