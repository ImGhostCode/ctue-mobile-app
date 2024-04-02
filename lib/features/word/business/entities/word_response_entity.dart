import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class WordResEntity {
  final int? totalPages;
  final int? total;
  List<WordEntity> data = [];

  WordResEntity({this.total, required this.data, this.totalPages});
}
