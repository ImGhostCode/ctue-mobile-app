import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';

class ObjectModel extends ObjectEntity {
  ObjectModel({required super.name, required super.confidence});

  factory ObjectModel.fromJson({required Map<String, dynamic> json}) {
    return ObjectModel(name: json[kName], confidence: json[kConfidence]);
  }

  Map<String, dynamic> toJson() {
    return {
      kName: name,
      kConfidence: confidence,
    };
  }
}
