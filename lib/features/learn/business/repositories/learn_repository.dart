import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/business/entities/learn_response_entity.dart';
import 'package:ctue_app/features/learn/business/entities/review_reminder_entity.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LearnRepository {
  Future<Either<Failure, ResponseDataModel<List<UserLearnedWordEntity>>>>
      saveLearnedResult({
    required SaveLearnedResultParams saveLearnedResultParams,
  });
  Future<Either<Failure, ResponseDataModel<ReviewReminderEntity>>>
      creReviewReminder({
    required CreReviewReminderParams creReviewReminderParams,
  });
  Future<Either<Failure, ResponseDataModel<ReviewReminderEntity?>>>
      getUpcomingReminder({
    required GetUpcomingReminderParams getUpcomingReminderParams,
  });
  Future<Either<Failure, ResponseDataModel<List<UserLearnedWordEntity>>>>
      getUserLearnedWords({
    required GetUserLearnedWordParams getUserLearnedWordParams,
  });
  Future<Either<Failure, ResponseDataModel<LearnResEntity>>>
      getLearningHistory({
    required GetLearningHistoryParams getLearningHistoryParams,
  });
}
