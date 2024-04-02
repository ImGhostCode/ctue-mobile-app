import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/features/sentence/business/entities/sen_response_entity.dart';
import 'package:ctue_app/features/sentence/business/repositories/sentece_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetSentencesUsecase {
  final SentenceRepository sentenceRepository;

  GetSentencesUsecase({required this.sentenceRepository});

  Future<Either<Failure, ResponseDataModel<SentenceResEntity>>> call({
    required GetSentenceParams getSentenceParams,
  }) async {
    return await sentenceRepository.getSentences(
        getSentenceParams: getSentenceParams);
  }
}
