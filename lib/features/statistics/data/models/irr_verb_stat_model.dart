import 'package:ctue_app/features/statistics/business/entities/irr_verb_stat_entity.dart';

import '../../../../../core/constants/constants.dart';

class IrrVerbStatisticsModel extends IrrVerbStatisticsEntity {
  const IrrVerbStatisticsModel({required super.total, required super.deleted});

  factory IrrVerbStatisticsModel.fromJson(
      {required Map<String, dynamic> json}) {
    return IrrVerbStatisticsModel(
      total: json[kTotal],
      deleted: json[kDeleted],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kDeleted: deleted,
    };
  }
}
