import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/business/entities/review_reminder_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/learn_repository.dart';

class GetUpcomingReminderUsecase {
  final LearnRepository learnRepository;

  GetUpcomingReminderUsecase({required this.learnRepository});

  Future<Either<Failure, ResponseDataModel<ReviewReminderEntity?>>> call({
    required GetUpcomingReminderParams getUpcomingReminderParams,
  }) async {
    return await learnRepository.getUpcomingReminder(
        getUpcomingReminderParams: getUpcomingReminderParams);
  }
}
