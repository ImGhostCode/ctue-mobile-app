import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/business/repositories/topic_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class GetTopicUsecase {
  final TopicRepository topicRepository;

  GetTopicUsecase({required this.topicRepository});

  Future<Either<Failure, ResponseDataModel<List<TopicEntity>>>> call({
    required TopicParams topicParams,
  }) async {
    return await topicRepository.getTopics(topicParams: topicParams);
  }
}
