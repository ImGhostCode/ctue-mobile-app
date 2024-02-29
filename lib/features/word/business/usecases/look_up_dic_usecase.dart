import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';

import 'package:ctue_app/features/word/business/repositories/word_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class LookUpDicUsecase {
  final WordRepository wordRepository;

  LookUpDicUsecase({required this.wordRepository});

  Future<Either<Failure, ResponseDataModel<List<WordEntity>>>> call({
    required LookUpDictionaryParams lookUpDictionaryParams,
  }) async {
    return await wordRepository.lookupDictionary(
        lookUpDictionaryParams: lookUpDictionaryParams);
  }
}
