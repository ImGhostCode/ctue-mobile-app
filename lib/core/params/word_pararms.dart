class GetWordParams {
  final int? id;
  List<int>? topic = [];
  List<int>? type = [];
  final int? level;
  final int? specialization;
  final int? page;
  final String? sort;
  final String? key;

  GetWordParams(
      {this.id,
      this.type,
      this.page,
      this.sort = 'asc',
      this.topic,
      this.level,
      this.specialization,
      this.key});
}

class LookUpDictionaryParams {
  final String key;

  LookUpDictionaryParams({required this.key});
}
