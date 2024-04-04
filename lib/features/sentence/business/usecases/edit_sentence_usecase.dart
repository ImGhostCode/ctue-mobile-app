import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/business/repositories/sentece_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class EditSentenceUsecase {
  final SentenceRepository sentenceRepository;

  EditSentenceUsecase({required this.sentenceRepository});

  Future<Either<Failure, ResponseDataModel<SentenceEntity>>> call({
    required EditSentenceParams editSentenceParams,
  }) async {
    return await sentenceRepository.updateSentence(
        editSentenceParams: editSentenceParams);
  }
}
