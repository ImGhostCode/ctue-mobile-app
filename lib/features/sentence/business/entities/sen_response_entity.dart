import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';

class SentenceResEntity {
  final int? totalPages;
  final int? total;
  List<SentenceEntity> data = [];

  SentenceResEntity({this.total, required this.data, this.totalPages});
}
