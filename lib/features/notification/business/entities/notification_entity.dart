import 'package:ctue_app/features/user/business/entities/user_entity.dart';

class NotificationEntity {
  final int id;
  final int userId;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final UserEntity? user;

  NotificationEntity(
      {required this.id,
      required this.title,
      required this.body,
      this.data,
      required this.createdAt,
      this.updatedAt,
      required this.userId,
      this.user});
}
