import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/sentence_params.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/core/params/type_params.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class SentenceRepository {
  Future<Either<Failure, ResponseDataModel<List<SentenceEntity>>>>
      getSentences({
    required GetSentenceParams getSentenceParams,
  });

  Future<Either<Failure, ResponseDataModel<SentenceEntity>>> getSentenceDetail({
    required GetSentenceParams getSentenceParams,
  });
}
