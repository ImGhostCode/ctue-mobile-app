import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/business/usecases/get_topics_usecase.dart';
import 'package:ctue_app/features/topic/data/repositories/topic_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/template_entity.dart';
import '../../business/usecases/get_template.dart';
import '../../data/datasources/template_local_data_source.dart';
import '../../data/datasources/topic_remote_data_source.dart';
import '../../data/repositories/template_repository_impl.dart';

class TopicProvider extends ChangeNotifier {
  List<TopicEntity>? listTopicEntity = [];
  Failure? failure;

  TopicProvider({
    this.listTopicEntity,
    this.failure,
  });

  void eitherFailureOrTopics(int? id, bool? isWord) async {
    TopicRepositoryImpl repository = TopicRepositoryImpl(
      remoteDataSource: TopicRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrTopic =
        await GetTopicUsecase(topicRepository: repository).call(
      topicParams: TopicParams(id: id, isWord: isWord),
    );

    failureOrTopic.fold(
      (Failure newFailure) {
        listTopicEntity = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<TopicEntity>> newTopics) {
        listTopicEntity = [
          TopicEntity(id: 0, name: 'Tất cả', isWord: false),
          ...newTopics.data
        ];
        failure = null;
        notifyListeners();
      },
    );
  }
}