import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/topic/data/models/topic_model.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/level/data/models/level_model.dart';
import 'package:ctue_app/features/specialization/data/models/specialization_model.dart';
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
      id: json[kId],
      content: json[kContent],

      isDeleted: json[kIsDeleted],
      note: json[kNote],
      userId: json[kUserId],
      topics: json[kTopic] != null
          ? json[kTopic]
              .map<TopicModel>(
                  (topicJson) => TopicModel.fromJson(json: topicJson))
              .toList() as List<TopicModel>
          : [],
      // type: TypeModel.fromJson(json: json['Type']),
      levelId: json[kLevelId],
      specializationId: json[kSpecializationId],
      meanings: json[kMeanings] != null
          ? json[kMeanings]
              .map<WordMeaningModel>(
                  (meaingJson) => WordMeaningModel.fromJson(json: meaingJson))
              .toList() as List<WordMeaningModel>
          : [],
      levelEntity:
          json[kLevel] != null ? LevelModel.fromJson(json: json[kLevel]) : null,
      specializationEntity: json[kSpecialization] != null
          ? SpecializationModel.fromJson(json: json[kSpecialization])
          : null,
      phonetic: json[kPhonetic],
      pictures: json[kPictures].map<String>((pic) => pic.toString()).toList(),
      examples: json[kExamples].map<String>((exam) => exam.toString()).toList(),
      synonyms: json[kSynonyms].map<String>((syn) => syn.toString()).toList(),
      antonyms: json[kAntonyms].map<String>((ant) => ant.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kLevelId: levelId,
      kSpecializationId: specializationId,
      kContent: content,
      kMeanings: (meanings as List<dynamic>)
          .map((meaning) => meaning.toJson())
          .toList(),
      kIsDeleted: isDeleted,
      kNote: note,
      kUserId: userId,
      kTopics:
          (topics as List<dynamic>).map((topic) => topic.toJson()).toList(),
      kPhonetic: phonetic,
      kPictures: pictures,
      kExamples: examples,
      kSynonyms: synonyms,
      kAntonyms: antonyms,
      kLevel: (levelEntity as LevelModel?)?.toJson(),
      kSpecialization: (specializationEntity as SpecializationModel?)?.toJson(),
    };
  }
}
