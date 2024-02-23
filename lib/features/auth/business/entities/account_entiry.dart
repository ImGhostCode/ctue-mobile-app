class AccountEntity {
  final String email;
  final int userId;
  final String authType;
  final String accountType;
  final bool isBan;
  final String? feedback;
  final bool isDeleted;

  AccountEntity(
      {required this.email,
      required this.userId,
      required this.authType,
      required this.accountType,
      required this.isBan,
      required this.feedback,
      required this.isDeleted});
}
