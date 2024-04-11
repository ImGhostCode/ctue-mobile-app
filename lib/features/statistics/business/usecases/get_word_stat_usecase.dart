import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/business/entities/word_stat_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/statistics_repository.dart';

class GetWordStatistics {
  final StatisticsRepository statisticsRepository;

  GetWordStatistics({required this.statisticsRepository});

  Future<Either<Failure, ResponseDataModel<WordStatisticsEntity>>> call({
    required StatisticsParams statisticsParams,
  }) async {
    return await statisticsRepository.getWordStatistics(
        statisticsParams: statisticsParams);
  }
}
