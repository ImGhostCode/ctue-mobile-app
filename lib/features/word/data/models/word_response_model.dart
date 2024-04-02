import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word/business/entities/word_response_entity.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';

class WordResModel extends WordResEntity {
  WordResModel({required super.data, super.total, super.totalPages});

  factory WordResModel.fromJson({required Map<String, dynamic> json}) {
    return WordResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<WordModel>((word) => WordModel.fromJson(json: word))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {kTotal: total, kTotalPages: totalPages, kData: data};
  }
}
