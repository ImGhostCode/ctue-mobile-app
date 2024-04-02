import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/business/entities/word_response_entity.dart';

import 'package:ctue_app/features/word/business/repositories/word_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetWordUsecase {
  final WordRepository wordRepository;

  GetWordUsecase({required this.wordRepository});

  Future<Either<Failure, ResponseDataModel<WordResEntity>>> call({
    required GetWordParams getWordParams,
  }) async {
    return await wordRepository.getWords(getWordParams: getWordParams);
  }
}
