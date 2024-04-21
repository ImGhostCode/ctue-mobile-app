import 'package:ctue_app/features/statistics/business/entities/contri_stat_entity.dart';

import '../../../../../core/constants/constants.dart';

class ContriStatisticsModel extends ContriStatisticsEntity {
  const ContriStatisticsModel(
      {required super.total,
      required super.pending,
      required super.refused,
      required super.approved});

  factory ContriStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return ContriStatisticsModel(
      total: json[kTotal],
      pending: json[kPending],
      refused: json[kRefused],
      approved: json[kApproved],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kPending: this.pending,
      kRefused: this.refused,
      kApproved: this.approved,
    };
  }
}
