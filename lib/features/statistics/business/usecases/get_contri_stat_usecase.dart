import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/business/entities/contri_stat_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/statistics_repository.dart';

class GetContriStatistics {
  final StatisticsRepository statisticsRepository;

  GetContriStatistics({required this.statisticsRepository});

  Future<Either<Failure, ResponseDataModel<ContriStatisticsEntity>>> call({
    required StatisticsParams statisticsParams,
  }) async {
    return await statisticsRepository.getContriStatistics(
        statisticsParams: statisticsParams);
  }
}
