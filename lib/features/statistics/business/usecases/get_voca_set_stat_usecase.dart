import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/business/entities/voca_set_stat_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/statistics_repository.dart';

class GetVocaSetStatistics {
  final StatisticsRepository statisticsRepository;

  GetVocaSetStatistics({required this.statisticsRepository});

  Future<Either<Failure, ResponseDataModel<VocaSetStatisticsEntity>>> call({
    required StatisticsParams statisticsParams,
  }) async {
    return await statisticsRepository.getVocaSetStatistics(
        statisticsParams: statisticsParams);
  }
}
