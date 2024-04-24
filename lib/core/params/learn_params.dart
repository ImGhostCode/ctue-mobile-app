import 'package:ctue_app/core/constants/constants.dart';

class SaveLearnedResultParams {
  List<int> wordIds = [];
  final int vocabularySetId;
  final int? reviewReminderId;
  List<int> memoryLevels = [];
  String accessToken;

  SaveLearnedResultParams(
      {required this.wordIds,
      required this.memoryLevels,
      required this.accessToken,
      required this.vocabularySetId,
      this.reviewReminderId});
}

class CreReviewReminderParams {
  final int vocabularySetId;
  List<DataRemindParams> data = [];
  final String accessToken;

  CreReviewReminderParams(
      {required this.data,
      required this.vocabularySetId,
      required this.accessToken});
}

class DataRemindParams {
  final int wordId;
  final DateTime reviewAt;

  DataRemindParams({required this.wordId, required this.reviewAt});

  Map<String, dynamic> toJson() {
    return {
      kWordId: wordId,
      kReviewAt: '${reviewAt.toString()}Z',
    };
  }
}

class GetUpcomingReminderParams {
  final String accessToken;
  final int? vocabularySetId;

  GetUpcomingReminderParams({required this.accessToken, this.vocabularySetId});
}

class GetUserLearnedWordParams {
  final String accessToken;
  final int? setId;

  GetUserLearnedWordParams({required this.accessToken, this.setId});
}

class GetLearningHistoryParams {
  final int page;
  final int? level;
  final String sort;
  final String accessToken;
  final int? userId;

  GetLearningHistoryParams(
      {required this.accessToken,
      this.userId,
      required this.page,
      required this.sort,
      required this.level});
}
