import 'package:ctue_app/features/specialization/data/models/specialization_model.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';

import '../../../../../core/constants/constants.dart';

class VocaSetModel extends VocaSetEntity {
  VocaSetModel(
      {required super.id,
      required super.title,
      required super.userId,
      required super.isPublic,
      required super.createdAt,
      required super.downloads,
      required super.words,
      super.isDeleted,
      super.picture,
      super.specId,
      super.specializationEntity,
      super.topicEntity,
      super.topicId,
      super.userEntity});

  factory VocaSetModel.fromJson({required Map<String, dynamic> json}) {
    return VocaSetModel(
        id: json[kId],
        title: json[kTitle],
        userId: json[kUserId],
        isPublic: json[kIsPublic],
        createdAt: DateTime.parse(json[kCreatedAt]),
        downloads: json[kDownloads],
        words: json[kWords] != null
            ? json[kWords]
                .map<WordModel>((word) => WordModel.fromJson(json: word))
                .toList()
            : [],
        isDeleted: json[kIsDeleted],
        picture: json[kPicture],
        specId: json[kSpecId],
        topicId: json[kTopicId],
        specializationEntity: (json[kSpecialization]) != null
            ? SpecializationModel.fromJson(json: json[kSpecialization])
            : null,
        topicEntity: json[kTopic] != null
            ? TopicModel.fromJson(json: json[kTopic])
            : null,
        userEntity:
            json[kUser] != null ? UserModel.fromJson(json: json[kUser]) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kTitle: title,
      kUserId: userId,
      kIsPublic: isPublic,
      kCreatedAt: createdAt,
      kDownloads: downloads,
      kWords: words,
      kIsDeleted: isDeleted,
      kPicture: picture,
      kSpecId: specId,
      kTopicId: topicId,
      kSpecialization: specializationEntity,
      kTopic: topicEntity,
      kUser: userEntity
    };
  }
}
