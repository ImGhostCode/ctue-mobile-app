import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_response_entity.dart';
import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_model.dart';

class IrrVerbResModel extends IrrVerbResEntity {
  IrrVerbResModel({required super.data, super.total, super.totalPages});

  factory IrrVerbResModel.fromJson({required Map<String, dynamic> json}) {
    return IrrVerbResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<IrrVerbModel>((verb) => IrrVerbModel.fromJson(json: verb))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {kTotal: total, kTotalPages: totalPages, kData: data};
  }
}
