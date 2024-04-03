import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_response_entity.dart';
import 'package:ctue_app/features/vocabulary_set/data/models/voca_set_model.dart';

class VocabularySetResModel extends VocabularySetResEntity {
  VocabularySetResModel({required super.data, super.total, super.totalPages});

  factory VocabularySetResModel.fromJson({required Map<String, dynamic> json}) {
    return VocabularySetResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<VocaSetModel>((set) => VocaSetModel.fromJson(json: set))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {kTotal: total, kTotalPages: totalPages, kData: data};
  }
}
