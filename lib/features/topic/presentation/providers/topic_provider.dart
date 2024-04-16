import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/topic_params.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/business/usecases/get_topics_usecase.dart';
import 'package:ctue_app/features/topic/data/datasources/topic_remote_data_source.dart';
import 'package:ctue_app/features/topic/data/repositories/topic_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class TopicProvider extends ChangeNotifier {
  List<TopicEntity> listTopicEntity = [];
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  TopicProvider({
    this.failure,
  });

  void handleSelectTopicComPhrase(int index) {
    if (index != 0) {
      listTopicEntity[0].isSelected = false;
    } else {
      for (var topic in listTopicEntity) {
        topic.isSelected = false;
      }
    }
    listTopicEntity[index].isSelected = !listTopicEntity[index].isSelected;
    if (getSelectedTopics().isEmpty) listTopicEntity[0].isSelected = true;
    notifyListeners();
  }

  void refreshTopics() {
    for (var element in listTopicEntity) {
      if (element.isSelected) {
        element.isSelected = false;
      }
    }
  }

  List<int> getSelectedTopics() {
    return listTopicEntity
        .where((topic) => topic.isSelected)
        .map((e) => e.id)
        .toList();
  }

  Future<List<TopicEntity>> eitherFailureOrTopics(
      int? id, bool? isWord, TopicEntity? init) async {
    _isLoading = true;

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
        _isLoading = false;
        listTopicEntity = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<TopicEntity>> newTopics) {
        _isLoading = false;
        listTopicEntity = newTopics.data;
        if (init != null) {
          listTopicEntity = [init, ...listTopicEntity];
        }
        failure = null;

        notifyListeners();
      },
    );
    return listTopicEntity;
  }
}
