import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word/business/entities/level_entity.dart';

class LevelModel extends LevelEntity {
  LevelModel({required super.id, required super.name});

  factory LevelModel.fromJson({required Map<String, dynamic> json}) {
    return LevelModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {kId: id, kName: name};
  }
}
