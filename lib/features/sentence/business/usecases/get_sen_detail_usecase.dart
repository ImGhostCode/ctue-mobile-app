import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/business/repositories/sentece_repository.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/business/repositories/topic_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetSenDetailUsecase {
  final SentenceRepository sentenceRepository;

  GetSenDetailUsecase({required this.sentenceRepository});

  Future<Either<Failure, ResponseDataModel<SentenceEntity>>> call({
    required GetSentenceParams getSentenceParams,
  }) async {
    return await sentenceRepository.getSentenceDetail(
        getSentenceParams: getSentenceParams);
  }
}
