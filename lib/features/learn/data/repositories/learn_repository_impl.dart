import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/data/models/review_reminder_model.dart';
import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/learn_repository.dart';
import '../datasources/learn_local_data_source.dart';
import '../datasources/learn_remote_data_source.dart';

class LearnRepositoryImpl implements LearnRepository {
  final LearnRemoteDataSource remoteDataSource;
  final LearnLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LearnRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<UserLearnedWordModel>>>>
      saveLearnedResult(
          {required SaveLearnedResultParams saveLearnedResultParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<UserLearnedWordModel>> remoteLearn =
            await remoteDataSource.saveLearnedResult(
                saveLearnedResultParams: saveLearnedResultParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteLearn);

        return Right(remoteLearn);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<ReviewReminderModel>>>
      creReviewReminder(
          {required CreReviewReminderParams creReviewReminderParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<ReviewReminderModel> remoteLearn =
            await remoteDataSource.creReviewReminder(
                creReviewReminderParams: creReviewReminderParams);

        // localDataSource.cacheVocaSet(VocaSetToCache: remoteLearn);

        return Right(remoteLearn);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<ReviewReminderModel?>>>
      getUpcomingReminder(
          {required GetUpcomingReminderParams
              getUpcomingReminderParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<ReviewReminderModel?> remoteLearn =
            await remoteDataSource.getUpcomingReminder(
                getUpcomingReminderParams: getUpcomingReminderParams);

        localDataSource.cacheReviewReminder(reviewReminderModel: remoteLearn);

        return Right(remoteLearn);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<ReviewReminderModel?> localReviewReminder =
            await localDataSource.getLastReviewReminder();
        if (getUpcomingReminderParams.vocabularySetId != null) {
          if (localReviewReminder.data?.vocabularySetId !=
              getUpcomingReminderParams.vocabularySetId) {
            return Left(
                CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
          }
        }
        return Right(localReviewReminder);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<List<UserLearnedWordModel>>>>
      getUserLearnedWords(
          {required GetUserLearnedWordParams getUserLearnedWordParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<UserLearnedWordModel>> remoteLearn =
            await remoteDataSource.getUserLearnedWords(
                getUserLearnedWordParams: getUserLearnedWordParams);

        localDataSource.cacheUserLeanredWords(userLearnedWords: remoteLearn);

        return Right(remoteLearn);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      try {
        ResponseDataModel<List<UserLearnedWordModel>> localUserLearnedWords =
            await localDataSource.getLastUserLearnedWords();

        return Right(localUserLearnedWords);
      } on CacheException {
        return Left(
            CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
      }
    }
  }

  // @override
  // Future<Either<Failure, ResponseDataModel<VocaSetStatisticsModel>>>
  //     getVocaSetStatistics(
  //         {required GetVocaSetStatisParams getVocaSetStatisParams}) async {
  //   if (await networkInfo.isConnected!) {
  //     try {
  //       ResponseDataModel<VocaSetStatisticsModel> remoteLearn =
  //           await remoteDataSource.getVocaSetStatistics(
  //               getVocaSetStatisParams: getVocaSetStatisParams);

  //       // localDataSource.cacheVocaSet(VocaSetToCache: remoteLearn);

  //       return Right(remoteLearn);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(
  //           errorMessage: e.errorMessage, statusCode: e.statusCode));
  //     }
  //   } else {
  //     return Left(CacheFailure(errorMessage: 'Không thể kết nối với máy chủ'));
  //   }
  // }
}
