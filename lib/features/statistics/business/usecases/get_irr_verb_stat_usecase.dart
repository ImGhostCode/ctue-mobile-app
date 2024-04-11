import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/business/entities/irr_verb_stat_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/statistics_repository.dart';

class GetIrrVerbStatistics {
  final StatisticsRepository statisticsRepository;

  GetIrrVerbStatistics({required this.statisticsRepository});

  Future<Either<Failure, ResponseDataModel<IrrVerbStatisticsEntity>>> call({
    required StatisticsParams statisticsParams,
  }) async {
    return await statisticsRepository.getIrrVerbStatistics(
        statisticsParams: statisticsParams);
  }
}
