import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class WordRepository {
  Future<Either<Failure, ResponseDataModel<WordResEntity>>> getWords({
    required GetWordParams getWordParams,
  });

  Future<Either<Failure, ResponseDataModel<WordEntity>>> getWordByContent({
    required GetWordByContentParams getWordByContentParams,
  });

  Future<Either<Failure, ResponseDataModel<WordEntity>>> getWordDetail({
    required GetWordParams getWordParams,
  });
  Future<Either<Failure, ResponseDataModel<WordEntity>>> createWord({
    required CreateWordParams createWordParams,
  });
  Future<Either<Failure, ResponseDataModel<WordEntity>>> updateWord({
    required UpdateWordParams updateWordParams,
  });
  Future<Either<Failure, ResponseDataModel<void>>> deleteWord({
    required DeleteWordParams deleteWordParams,
  });

  Future<Either<Failure, ResponseDataModel<List<WordEntity>>>>
      lookupDictionary({
    required LookUpDictionaryParams lookUpDictionaryParams,
  });

  Future<Either<Failure, ResponseDataModel<List<ObjectEntity>>>> lookupByImage({
    required LookUpByImageParams lookUpByImageParams,
  });
}
