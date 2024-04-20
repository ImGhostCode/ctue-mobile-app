import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';

class TopicModel extends TopicEntity {
  TopicModel(
      {required super.id,
      required super.name,
      required super.isWord,
      super.image});

  factory TopicModel.fromJson({required Map<String, dynamic> json}) {
    return TopicModel(
        id: json[kId],
        name: json[kName],
        isWord: json[kisWord],
        image: json[kImage]);
  }

  Map<String, dynamic> toJson() {
    return {kId: id, kName: name, kisWord: isWord, kImage: image};
  }
}
