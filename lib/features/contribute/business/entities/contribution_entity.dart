import 'package:ctue_app/features/user/business/entities/user_entity.dart';

class ContributionEntity {
  final int id;
  final int userId;
  final String type;
  final Map<String, dynamic> content;
  final int status;
  final String? feedback;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final UserEntity? user;

  ContributionEntity(
      {required this.id,
      required this.content,
      required this.type,
      required this.status,
      this.feedback = '',
      required this.userId,
      required this.createdAt,
      this.isDeleted = false,
      required this.updatedAt,
      this.user});
}
