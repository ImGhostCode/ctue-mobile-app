import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';
import 'package:ctue_app/features/type/data/models/type_model.dart';

class SentenceModel extends SentenceEntity {
  SentenceModel(
      {required super.id,
      required super.typeId,
      required super.content,
      required super.meaning,
      super.isDeleted,
      super.note,
      super.userId,
      super.topics,
      super.type});

  factory SentenceModel.fromJson({required Map<String, dynamic> json}) {
    return SentenceModel(
      id: json['id'],
      typeId: json['typeId'],
      content: json['content'],
      meaning: json['meaning'],
      isDeleted: json['isDeleted'],
      note: json['note'],
      userId: json['userId'],
      topics: json['Topic']
          .map<TopicModel>((topicJson) => TopicModel.fromJson(json: topicJson))
          .toList(),
      type: TypeModel.fromJson(json: json['Type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kTypeId: typeId,
      kContent: content,
      kMean: meaning,
      kIsDeleted: isDeleted,
      kNote: note,
      kUserId: userId,
      kTopics: topics,
      kType: type
    };
  }
}
