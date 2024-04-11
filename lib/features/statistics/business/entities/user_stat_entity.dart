class UserStatisticsEntity {
  final int total;
  final int active;
  final int banned;
  final int deleted;
  const UserStatisticsEntity(
      {required this.total,
      required this.active,
      required this.banned,
      required this.deleted});
}
