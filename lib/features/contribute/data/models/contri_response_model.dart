import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/contribute/business/entities/contri_response_entity.dart';
import 'package:ctue_app/features/contribute/data/models/contribution_model.dart';

class ContributionResModel extends ContributionResEntity {
  ContributionResModel({required super.data, super.total, super.totalPages});

  factory ContributionResModel.fromJson({required Map<String, dynamic> json}) {
    return ContributionResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<ContributionModel>((contribution) =>
                ContributionModel.fromJson(json: contribution))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {kTotal: total, kTotalPages: totalPages, kData: data};
  }
}
