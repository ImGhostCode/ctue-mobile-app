class GetSentenceParams {
  final int? id;
  List<int>? topics = [];
  final int? type;
  final int? page;
  final String? sort;

  GetSentenceParams(
      {this.id, this.type, this.page, this.sort = 'asc', this.topics});
}
