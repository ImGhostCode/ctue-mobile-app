import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/sentence/business/entities/sen_response_entity.dart';
import 'package:ctue_app/features/sentence/data/models/sentence_model.dart';

class SentenceResModel extends SentenceResEntity {
  SentenceResModel({required super.data, super.total, super.totalPages});

  factory SentenceResModel.fromJson({required Map<String, dynamic> json}) {
    return SentenceResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<SentenceModel>((sen) => SentenceModel.fromJson(json: sen))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {kTotal: total, kTotalPages: totalPages, kData: data};
  }
}
