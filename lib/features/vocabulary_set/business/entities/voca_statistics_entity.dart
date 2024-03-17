import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';

class VocaSetStatisticsEntity {
  final int numberOfWords;
  final DetailVocaSetStatisEntity detailVocaSetStatisEntity;

  VocaSetStatisticsEntity(
      {required this.numberOfWords, required this.detailVocaSetStatisEntity});
}

class DetailVocaSetStatisEntity {
  final List<UserLearnedWordEntity> level_1;
  final List<UserLearnedWordEntity> level_2;
  final List<UserLearnedWordEntity> level_3;
  final List<UserLearnedWordEntity> level_4;
  final List<UserLearnedWordEntity> level_5;
  final List<UserLearnedWordEntity> level_6;

  DetailVocaSetStatisEntity(
      {this.level_1 = const [],
      this.level_2 = const [],
      this.level_3 = const [],
      this.level_4 = const [],
      this.level_5 = const [],
      this.level_6 = const []});
}
