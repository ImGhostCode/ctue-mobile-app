import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';

import 'package:ctue_app/features/word/business/repositories/word_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class LookUpByImageUsecase {
  final WordRepository wordRepository;

  LookUpByImageUsecase({required this.wordRepository});

  Future<Either<Failure, ResponseDataModel<List<ObjectEntity>>>> call({
    required LookUpByImageParams lookUpDictionaryParams,
  }) async {
    return await wordRepository.lookupByImage(
        lookUpByImageParams: lookUpDictionaryParams);
  }
}
