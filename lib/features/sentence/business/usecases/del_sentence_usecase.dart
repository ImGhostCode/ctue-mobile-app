import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/features/sentence/business/repositories/sentece_repository.dart';

import 'package:dartz/dartz.dart';

class DeleteSentenceUsecase {
  final SentenceRepository sentenceRepository;

  DeleteSentenceUsecase({required this.sentenceRepository});

  Future<Either<Failure, ResponseDataModel<void>>> call({
    required DeleteSentenceParams deleteSentenceParams,
  }) async {
    return await sentenceRepository.deleteSentence(
        deleteSentenceParams: deleteSentenceParams);
  }
}
