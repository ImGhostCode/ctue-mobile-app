import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';

class LearnResEntity {
  final int? totalPages;
  final int? total;
  List<UserLearnedWordEntity> data = [];

  LearnResEntity({this.total, required this.data, this.totalPages});
}
