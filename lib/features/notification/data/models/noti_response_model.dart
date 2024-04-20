import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/notification/business/entities/noti_response_entity.dart';
import 'package:ctue_app/features/notification/data/models/notification_model.dart';

class NotiResModel extends NotiResEntity {
  NotiResModel({required super.data, super.total, super.totalPages});

  factory NotiResModel.fromJson({required Map<String, dynamic> json}) {
    return NotiResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<NotificationModel>(
                (noti) => NotificationModel.fromJson(json: noti))
            .toList() as List<NotificationModel>);
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kTotalPages: totalPages,
      kData: (data as List<NotificationModel>).map((e) => e.toJson()).toList(),
    };
  }
}
