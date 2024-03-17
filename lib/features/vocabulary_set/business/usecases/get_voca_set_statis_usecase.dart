import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_statistics_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/voca_set_repository.dart';

class GetVocaSetStatisUsecase {
  final VocaSetRepository vocaSetRepository;

  GetVocaSetStatisUsecase({required this.vocaSetRepository});

  Future<Either<Failure, ResponseDataModel<VocaSetStatisticsEntity>>> call({
    required GetVocaSetStatisParams getVocaSetStatisParams,
  }) async {
    return await vocaSetRepository.getVocaSetStatistics(
        getVocaSetStatisParams: getVocaSetStatisParams);
  }
}
