import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class WordRepository {
  Future<Either<Failure, ResponseDataModel<List<WordEntity>>>> getWords({
    required GetWordParams getWordParams,
  });

  Future<Either<Failure, ResponseDataModel<WordEntity>>> getWordDetail({
    required GetWordParams getWordParams,
  });

  Future<Either<Failure, ResponseDataModel<List<WordEntity>>>>
      lookupDictionary({
    required LookUpDictionaryParams lookUpDictionaryParams,
  });
}
