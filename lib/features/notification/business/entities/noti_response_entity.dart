import 'package:ctue_app/features/notification/business/entities/notification_entity.dart';

class NotiResEntity {
  final int? totalPages;
  final int? total;
  List<NotificationEntity> data = [];

  NotiResEntity({this.total, required this.data, this.totalPages});
}
