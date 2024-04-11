import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/statistics_params.dart';
import 'package:ctue_app/features/statistics/business/entities/user_stat_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/statistics_repository.dart';

class GetUserStatistics {
  final StatisticsRepository statisticsRepository;

  GetUserStatistics({required this.statisticsRepository});

  Future<Either<Failure, ResponseDataModel<UserStatisticsEntity>>> call({
    required StatisticsParams statisticsParams,
  }) async {
    return await statisticsRepository.getUserStatistics(
        statisticsParams: statisticsParams);
  }
}
