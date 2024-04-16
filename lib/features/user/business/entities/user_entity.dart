import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';

class UserEntity {
  final int id;
  final String name;
  final String? avt;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? accountType;
  List<TopicEntity>? interestTopics = [];
  UserEntity(
      {required this.id,
      required this.name,
      this.avt,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt,
      this.accountType = AccountType.user,
      this.interestTopics = const []});
}
