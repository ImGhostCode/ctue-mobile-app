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

// sort: any, types: number[], level: number, specialization: number, topic: [], page: number, key: string