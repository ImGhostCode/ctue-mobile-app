class IrrVerbEntity {
  final String v1;
  final String v2;
  final String v3;
  final String meaning;
  final bool isDeleted;
  const IrrVerbEntity({
    required this.v1,
    required this.v2,
    required this.v3,
    required this.meaning,
    this.isDeleted = false,
  });
}
