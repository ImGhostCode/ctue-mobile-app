import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/data/models/level_model.dart';
import 'package:ctue_app/features/word/data/models/specialization_model.dart';
import 'package:ctue_app/features/word/data/models/word_meaing_model.dart';

class WordModel extends WordEntity {
  WordModel(
      {required super.id,
      super.userId,
      required super.levelId,
      required super.specializationId,
      required super.content,
      required super.meanings,
      super.isDeleted,
      super.note,
      super.levelEntity,
      super.specializationEntity,
      super.topics,
      required super.phonetic,
      required super.pictures,
      required super.examples,
      required super.synonyms,
      required super.antonyms});

  factory WordModel.fromJson({required Map<String, dynamic> json}) {
    return WordModel(
      id: json['id'],
      content: json['content'],

      isDeleted: json['isDeleted'],
      note: json['note'],
      userId: json['userId'],
      topics: json['Topic'] != null
          ? json['Topic']
              .map<TopicModel>(
                  (topicJson) => TopicModel.fromJson(json: topicJson))
              .toList()
          : [],
      // type: TypeModel.fromJson(json: json['Type']),
      levelId: json['levelId'],
      specializationId: json['specializationId'],
      meanings: json['meanings'] != null
          ? json['meanings']
              .map<WordMeaningModel>(
                  (meaingJson) => WordMeaningModel.fromJson(json: meaingJson))
              .toList()
          : [],
      levelEntity: json['Level'] != null
          ? LevelModel.fromJson(json: json['Level'])
          : null,
      specializationEntity: json['Specialization'] != null
          ? SpecializationModel.fromJson(json: json['Specialization'])
          : null,
      phonetic: json['phonetic'],
      pictures: json['pictures'].map<String>((pic) => pic.toString()).toList(),
      examples:
          json['examples'].map<String>((exam) => exam.toString()).toList(),
      synonyms: json['synonyms'].map<String>((syn) => syn.toString()).toList(),
      antonyms: json['antonyms'].map<String>((ant) => ant.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kLevelId: levelId,
      kSpecializationId: specializationId,
      kContent: content,
      kMeanings: meanings,
      kIsDeleted: isDeleted,
      kNote: note,
      kUserId: userId,
      kTopics: topics,
      kPhonetic: phonetic,
      kPictures: pictures,
      kExamples: examples,
      kSynonyms: synonyms,
      kAntonyms: antonyms
    };
  }
}
