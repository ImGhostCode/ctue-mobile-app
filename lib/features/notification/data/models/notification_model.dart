import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/notification/business/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel(
      {required super.id,
      required super.title,
      required super.body,
      required super.createdAt,
      required super.userId,
      super.data,
      super.updatedAt,
      super.user});

  factory NotificationModel.fromJson({required Map<String, dynamic> json}) {
    return NotificationModel(
      id: json[kId],
      title: json[kTitle],
      userId: json[kUserId],
      body: json[kBody],
      data: json[kData],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
      user: json[kUser],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kTitle: title,
      kUserId: userId,
      kBody: body,
      kData: data,
      kCreatedAt: createdAt,
      kUpdatedAt: updatedAt,
      kUser: user,
    };
  }
}
