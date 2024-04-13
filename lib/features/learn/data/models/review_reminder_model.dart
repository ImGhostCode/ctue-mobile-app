import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/learn/business/entities/review_reminder_entity.dart';
import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';
// import 'package:ctue_app/features/word/data/models/word_model.dart';

class ReviewReminderModel extends ReviewReminderEntity {
  ReviewReminderModel(
      {required super.id,
      required super.vocabularySetId,
      required super.userId,
      required super.isDone,
      required super.learnedWords,
      required super.reviewAt,
      required super.createdAt,
      super.userEntity,
      super.vocaSetEntity});

  factory ReviewReminderModel.fromJson({required Map<String, dynamic> json}) {
    return ReviewReminderModel(
        id: json[kId],
        userId: json[kUserId],
        vocabularySetId: json[kVocaSetId],
        isDone: json[kIsDone],
        reviewAt: DateTime.parse(json[kReviewAt]),
        createdAt: DateTime.parse(json[kCreatedAt]),
        learnedWords: json[kLearnedWords]
            .map<UserLearnedWordModel>(
                (word) => UserLearnedWordModel.fromJson(json: word))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kUserId: userId,
      kIsDone: isDone,
      kReviewAt: reviewAt,
      kCreatedAt: createdAt,
      kVocaSetId: vocabularySetId,
      kLearnedWords: learnedWords,
    };
  }
}
