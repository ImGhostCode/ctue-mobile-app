import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_entity.dart';

class VocabularySetResEntity {
  final int? totalPages;
  final int? total;
  List<VocaSetEntity> data = [];

  VocabularySetResEntity({this.total, required this.data, this.totalPages});
}
