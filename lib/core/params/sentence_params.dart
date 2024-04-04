class GetSentenceParams {
  final int? id;
  List<int>? topics = [];
  final int? type;
  final int? page;
  final String? sort;

  GetSentenceParams(
      {this.id, this.type, this.page, this.sort = 'asc', this.topics});
}

class CreateSentenceParams {
  List<dynamic> topicId = [];
  final int typeId;
  final String content;
  final String meaning;
  final String? note;
  final String accessToken;

  CreateSentenceParams(
      {required this.content,
      required this.meaning,
      required this.topicId,
      this.note,
      required this.typeId,
      required this.accessToken});
}

class EditSentenceParams {
  final int sentenceId;
  List<dynamic> topicId = [];
  final int typeId;
  final String content;
  final String meaning;
  final String? note;
  final String accessToken;

  EditSentenceParams(
      {required this.sentenceId,
      required this.content,
      required this.meaning,
      required this.topicId,
      this.note,
      required this.typeId,
      required this.accessToken});
}

class DeleteSentenceParams {
  final int sentenceId;
  final String accessToken;

  DeleteSentenceParams({required this.accessToken, required this.sentenceId});
}
