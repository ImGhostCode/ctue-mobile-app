import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/specialization/business/entities/specialization_entity.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class VocaSetEntity {
  final int id;
  final String title;
  final int userId;
  final int? topicId;
  final int? specId;
  final String? picture;
  final bool isPublic;
  final DateTime createdAt;
  final bool isDeleted;
  final int downloads;
  final List<WordEntity> words;
  final SpecializationEntity? specializationEntity;
  final TopicEntity? topicEntity;
  final UserEntity? userEntity;

  const VocaSetEntity(
      {required this.id,
      required this.title,
      required this.userId,
      this.topicId,
      this.specId,
      this.picture,
      required this.isPublic,
      this.isDeleted = false,
      required this.createdAt,
      required this.downloads,
      required this.words,
      this.specializationEntity,
      this.topicEntity,
      this.userEntity});
}
