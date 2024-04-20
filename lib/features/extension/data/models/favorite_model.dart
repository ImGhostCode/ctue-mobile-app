import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';
import 'package:ctue_app/features/word/data/models/word_model.dart';

class FavoriteModel extends FavoriteEntity {
  FavoriteModel({required super.id, required super.userId, super.words});

  factory FavoriteModel.fromJson({required Map<String, dynamic> json}) {
    return FavoriteModel(
        id: json[kId],
        userId: json[kUserId],
        words: json[kWord] != null
            ? json[kWord]
                .map<WordModel>(
                    (wordJson) => WordModel.fromJson(json: wordJson))
                .toList() as List<WordModel>
            : []);
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kUserId: userId,
      kWords: (words as List<dynamic>).map((e) => e.toJson()).toList()
    };
  }
}
