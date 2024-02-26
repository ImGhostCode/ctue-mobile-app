import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';

class SentenceEntity {
  final int id;
  final int typeId;
  final int? userId;
  final String content;
  final String mean;
  final String? note;
  final bool isDeleted;
  final List<TopicEntity>? topics;
  final TypeEntity? type;

  const SentenceEntity(
      {required this.id,
      required this.typeId,
      this.userId,
      required this.content,
      required this.mean,
      this.note,
      this.isDeleted = false,
      this.topics,
      this.type});
}
