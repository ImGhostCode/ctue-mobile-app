class ObjectEntity {
  final int x;
  final int y;
  final int width;
  final int height;
  final List<TagEntity> tags;
  ObjectEntity(
      {required this.tags,
      required this.x,
      required this.y,
      required this.width,
      required this.height});
}

class TagEntity {
  final String name;
  final double confidence;
  TagEntity({required this.name, required this.confidence});
}
