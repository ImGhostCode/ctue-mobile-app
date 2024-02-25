class SentenceEntity {
  final int id;
  final int typeId;
  final int? userId;
  final String content;
  final String mean;
  final String? note;
  final bool isDeleted;

  const SentenceEntity(
      {required this.id,
      required this.typeId,
      this.userId,
      required this.content,
      required this.mean,
      this.note,
      this.isDeleted = false});
}
