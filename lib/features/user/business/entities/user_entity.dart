class UserEntity {
  final int id;
  final String name;
  final String? avt;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserEntity({
    required this.id,
    required this.name,
    this.avt,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });
}
