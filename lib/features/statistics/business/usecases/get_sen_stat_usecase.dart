import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/business/entities/sen_stat_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/statistics_repository.dart';

class GetSenStatistics {
  final StatisticsRepository statisticsRepository;

  GetSenStatistics({required this.statisticsRepository});

  Future<Either<Failure, ResponseDataModel<SenStatisticsEntity>>> call({
    required StatisticsParams statisticsParams,
  }) async {
    return await statisticsRepository.getSenStatistics(
        statisticsParams: statisticsParams);
  }
}
