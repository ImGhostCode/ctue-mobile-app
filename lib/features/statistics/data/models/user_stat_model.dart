import '../../../../../core/constants/constants.dart';
import '../../business/entities/user_stat_entity.dart';

class UserStatisticsModel extends UserStatisticsEntity {
  const UserStatisticsModel(
      {required super.total,
      required super.active,
      required super.banned,
      required super.deleted});

  factory UserStatisticsModel.fromJson({required Map<String, dynamic> json}) {
    return UserStatisticsModel(
      total: json[kTotal],
      active: json[kActive],
      banned: json[kBanned],
      deleted: json[kDeleted],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kActive: active,
      kBanned: banned,
      kDeleted: deleted,
    };
  }
}
