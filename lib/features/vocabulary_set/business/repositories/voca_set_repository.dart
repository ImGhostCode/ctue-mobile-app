import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_response_entity.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_statistics_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/voca_set_params.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';

abstract class VocaSetRepository {
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> createVocaSet({
    required CreVocaSetParams creVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<List<VocaSetEntity>>>>
      getUserVocaSets({
    required GetVocaSetParams getVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<List<VocaSetEntity>>>> getVocaSets({
    required GetVocaSetParams getVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<VocabularySetResEntity>>>
      getVocaSetsByAdmin({
    required GetVocaSetParams getVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> getVocaSetDetail({
    required GetVocaSetParams getVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> updateVocaSet({
    required UpdateVocaSetParams updateVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> removeVocaSet({
    required RemoveVocaSetParams removeVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> downloadVocaSet({
    required DownloadVocaSetParams downloadVocaSetParams,
  });
  Future<Either<Failure, ResponseDataModel<VocaSetStatisticsEntity>>>
      getVocaSetStatistics({
    required GetVocaSetStatisParams getVocaSetStatisParams,
  });
}
