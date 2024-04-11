import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/business/entities/contri_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/irr_verb_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/sen_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/user_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/voca_set_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/word_stat_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, ResponseDataModel<UserStatisticsEntity>>>
      getUserStatistics({
    required StatisticsParams statisticsParams,
  });
  Future<Either<Failure, ResponseDataModel<ContriStatisticsEntity>>>
      getContriStatistics({
    required StatisticsParams statisticsParams,
  });
  Future<Either<Failure, ResponseDataModel<WordStatisticsEntity>>>
      getWordStatistics({
    required StatisticsParams statisticsParams,
  });
  Future<Either<Failure, ResponseDataModel<SenStatisticsEntity>>>
      getSenStatistics({
    required StatisticsParams statisticsParams,
  });
  Future<Either<Failure, ResponseDataModel<IrrVerbStatisticsEntity>>>
      getIrrVerbStatistics({
    required StatisticsParams statisticsParams,
  });
  Future<Either<Failure, ResponseDataModel<VocaSetStatisticsEntity>>>
      getVocaSetStatistics({
    required StatisticsParams statisticsParams,
  });
}
