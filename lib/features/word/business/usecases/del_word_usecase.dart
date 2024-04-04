import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/word_pararms.dart';
import 'package:ctue_app/features/word/business/repositories/word_repository.dart';

import 'package:dartz/dartz.dart';

class DeleteWordUsecase {
  final WordRepository wordRepository;

  DeleteWordUsecase({required this.wordRepository});

  Future<Either<Failure, ResponseDataModel<void>>> call({
    required DeleteWordParams deleteWordParams,
  }) async {
    return await wordRepository.deleteWord(deleteWordParams: deleteWordParams);
  }
}
