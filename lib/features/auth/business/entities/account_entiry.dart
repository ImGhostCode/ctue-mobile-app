import 'package:ctue_app/features/user/business/entities/user_entity.dart';

class AccountEntity {
  final String email;
  final int userId;
  final String authType;
  final String accountType;
  bool isBan;
  final String? feedback;
  final bool isDeleted;
  final UserEntity? user;

  AccountEntity(
      {required this.email,
      required this.userId,
      required this.authType,
      required this.accountType,
      required this.isBan,
      required this.feedback,
      required this.isDeleted,
      this.user});
}
