class TopicEntity {
  final int id;
  final String name;
  final bool isWord;
  final String image;
  bool isSelected;

  TopicEntity(
      {required this.id,
      required this.name,
      required this.isWord,
      this.image = '',
      this.isSelected = false});
}
