import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_response_entity.dart';
import 'package:ctue_app/features/vocabulary_pack/data/models/voca_set_model.dart';

class VocabularySetResModel extends VocabularySetResEntity {
  VocabularySetResModel({required super.data, super.total, super.totalPages});

  factory VocabularySetResModel.fromJson({required Map<String, dynamic> json}) {
    return VocabularySetResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<VocaSetModel>((set) => VocaSetModel.fromJson(json: set))
            .toList() as List<VocaSetModel>);
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kTotalPages: totalPages,
      kData: (data as List<dynamic>).map((e) => e.toJson()).toList()
    };
  }
}
