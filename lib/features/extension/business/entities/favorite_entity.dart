import 'package:ctue_app/features/word/business/entities/word_entity.dart';

class FavoriteEntity {
  final int id;
  final int userId;
  List<WordEntity>? words;

  FavoriteEntity({required this.id, required this.userId, this.words});
}
