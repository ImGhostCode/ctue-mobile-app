class SaveLearnedResultParams {
  List<int> wordIds = [];
  final int vocabularySetId;
  List<int> memoryLevels = [];
  String accessToken;

  SaveLearnedResultParams(
      {required this.wordIds,
      required this.memoryLevels,
      required this.accessToken,
      required this.vocabularySetId});
}
