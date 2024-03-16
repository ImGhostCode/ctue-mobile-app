import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class PronuncStatisticEntity {
  final int avg;
  final List<DetailEntity> detail;
  List<DetailEntity> lablesNeedToBeImprove = [];
  List<DetailEntity> lablesDoWell = [];
  List<WordEntity> suggestWordsToImprove = [];

  PronuncStatisticEntity(
      {required this.avg,
      required this.detail,
      this.lablesNeedToBeImprove = const [],
      this.lablesDoWell = const [],
      this.suggestWordsToImprove = const []});
}

class DetailEntity {
  final String label;
  final int avg;

  DetailEntity({required this.label, required this.avg});
}
