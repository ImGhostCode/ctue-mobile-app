import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';

class ObjectModel extends ObjectEntity {
  ObjectModel(
      {required super.tags,
      required super.x,
      required super.y,
      required super.width,
      required super.height});

  factory ObjectModel.fromJson({required Map<String, dynamic> json}) {
    return ObjectModel(
        tags: json[kTags] != null
            ? json[kTags]
                .map<TagsModel>((tagJson) => TagsModel.fromJson(json: tagJson))
                .toList() as List<TagsModel>
            : [],
        x: json[kX],
        y: json[kY],
        width: json[kWidth],
        height: json[kHeight]);
  }

  Map<String, dynamic> toJson() {
    return {
      kTags: (tags as List<dynamic>).map((e) => e.toJson()).toList(),
      kX: x,
      kY: y,
      kWidth: width,
      kHeight: height
    };
  }
}

class TagsModel extends TagEntity {
  TagsModel({required super.name, required super.confidence});

  factory TagsModel.fromJson({required Map<String, dynamic> json}) {
    return TagsModel(name: json[kName], confidence: json[kConfidence]);
  }

  Map<String, dynamic> toJson() {
    return {kName: name, kConfidence: confidence};
  }
}
