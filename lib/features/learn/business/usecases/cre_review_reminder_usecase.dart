import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/business/entities/review_reminder_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/learn_repository.dart';

class CreReviewReminderUsecase {
  final LearnRepository learnRepository;

  CreReviewReminderUsecase({required this.learnRepository});

  Future<Either<Failure, ResponseDataModel<ReviewReminderEntity>>> call({
    required CreReviewReminderParams creReviewReminderParams,
  }) async {
    return await learnRepository.creReviewReminder(
        creReviewReminderParams: creReviewReminderParams);
  }
}
