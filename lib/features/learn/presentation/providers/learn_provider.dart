import 'package:ctue_app/core/connection/network_info.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/core/services/shared_pref_service.dart';
import 'package:ctue_app/features/learn/business/entities/review_reminder_entity.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:ctue_app/features/learn/business/usecases/cre_review_reminder_usecase.dart';
import 'package:ctue_app/features/learn/business/usecases/save_learned_res_usecase.dart';
import 'package:ctue_app/features/learn/data/datasources/learn_local_data_source.dart';
import 'package:ctue_app/features/learn/data/datasources/learn_remote_data_source.dart';
import 'package:ctue_app/features/learn/data/repositories/learn_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearnProvider extends ChangeNotifier {
  final prefs = SharedPrefService.prefs;
  Failure? failure;
  String? message = '';
  int? statusCode;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserLearnedWordEntity> saveResults = [];
  ReviewReminderEntity? createdReviewReminder;

  TimeOfDay? _remindTime;
  bool? _isRemind = true;

  bool get isRemind {
    return prefs.getBool('is_remind') ?? _isRemind!;
  }

  set isRemind(bool value) {
    _isRemind = value;
    prefs.setBool('is_remind', value);
    notifyListeners();
  }

  TimeOfDay get remindTime {
    if (_remindTime != null) {
      return _remindTime!; // Return cached value if available
    }

    final storedRemindTime = prefs.getString('remind_time');
    if (storedRemindTime != null) {
      final parts = storedRemindTime.split(':'); // Split into hours and minutes
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } else {
      return const TimeOfDay(hour: 21, minute: 00); // Default value
    }
  }

  set remindTime(TimeOfDay value) {
    _remindTime = value; // Update cached value
    prefs.setString('remind_time', "${value.hour}:${value.minute}");
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int _nWMaxNumOfWords = 5;
  int _nWNumOfWritting = 1;
  int _nWNumOfListening = 1;
  int _nWNumOfChooseWord = 1;
  int _nWNumOfChooseMeaning = 1;

  set nWMaxNumOfWords(int value) {
    _nWMaxNumOfWords = value;
    prefs.setInt('nWMaxNumOfWords', value).then((value) => {notifyListeners()});
  }

  int get nWMaxNumOfWords {
    if (prefs.getInt('nWMaxNumOfWords') != null) {
      return prefs.getInt('nWMaxNumOfWords')!;
    } else {
      return _nWMaxNumOfWords;
    }
  }

  set nWNumOfWritting(int value) {
    _nWNumOfWritting = value;
    prefs
        .setInt('_nWNumOfWritting', value)
        .then((value) => {notifyListeners()});
  }

  int get nWNumOfWritting {
    if (prefs.getInt('_nWNumOfWritting') != null) {
      return prefs.getInt('_nWNumOfWritting')!;
    } else {
      return _nWNumOfWritting;
    }
  }

  set nWNumOfListening(int value) {
    _nWNumOfListening = value;
    prefs
        .setInt('_nWNumOfListening', value)
        .then((value) => {notifyListeners()});
  }

  int get nWNumOfListening {
    if (prefs.getInt('_nWNumOfListening') != null) {
      return prefs.getInt('_nWNumOfListening')!;
    } else {
      return _nWNumOfListening;
    }
  }

  set nWNumOfChooseWord(int value) {
    _nWNumOfChooseWord = value;
    prefs
        .setInt('_nWNumOfChooseWord', value)
        .then((value) => {notifyListeners()});
  }

  int get nWNumOfChooseWord {
    if (prefs.getInt('_nWNumOfChooseWord') != null) {
      return prefs.getInt('_nWNumOfChooseWord')!;
    } else {
      return _nWNumOfChooseWord;
    }
  }

  set nWNumOfChooseMeaning(int value) {
    _nWNumOfChooseMeaning = value;
    prefs
        .setInt('_nWNumOfChooseMeaning', value)
        .then((value) => {notifyListeners()});
  }

  int get nWNumOfChooseMeaning {
    if (prefs.getInt('_nWNumOfChooseMeaning') != null) {
      return prefs.getInt('_nWNumOfChooseMeaning')!;
    } else {
      return _nWNumOfChooseMeaning;
    }
  }

  int _oWMaxNumOfWords = 5;
  int _oWNumOfWritting = 1;
  int _oWNumOfListening = 1;
  int _oWNumOfChooseWord = 1;
  int _oWNumOfChooseMeaning = 1;

  set oWMaxNumOfWords(int value) {
    _oWMaxNumOfWords = value;
    prefs.setInt('oWMaxNumOfWords', value).then((value) => {notifyListeners()});
  }

  int get oWMaxNumOfWords {
    if (prefs.getInt('oWMaxNumOfWords') != null) {
      return prefs.getInt('oWMaxNumOfWords')!;
    } else {
      return _oWMaxNumOfWords;
    }
  }

  set oWNumOfWritting(int value) {
    _oWNumOfWritting = value;
    prefs
        .setInt('_oWNumOfWritting', value)
        .then((value) => {notifyListeners()});
  }

  int get oWNumOfWritting {
    if (prefs.getInt('_oWNumOfWritting') != null) {
      return prefs.getInt('_oWNumOfWritting')!;
    } else {
      return _oWNumOfWritting;
    }
  }

  set oWNumOfListening(int value) {
    _oWNumOfListening = value;
    prefs
        .setInt('_oWNumOfListening', value)
        .then((value) => {notifyListeners()});
  }

  int get oWNumOfListening {
    if (prefs.getInt('_oWNumOfListening') != null) {
      return prefs.getInt('_oWNumOfListening')!;
    } else {
      return _oWNumOfListening;
    }
  }

  set oWNumOfChooseWord(int value) {
    _oWNumOfChooseWord = value;
    prefs
        .setInt('_oWNumOfChooseWord', value)
        .then((value) => {notifyListeners()});
  }

  int get oWNumOfChooseWord {
    if (prefs.getInt('_oWNumOfChooseWord') != null) {
      return prefs.getInt('_oWNumOfChooseWord')!;
    } else {
      return _oWNumOfChooseWord;
    }
  }

  set oWNumOfChooseMeaning(int value) {
    _oWNumOfChooseMeaning = value;
    prefs
        .setInt('_oWNumOfChooseMeaning', value)
        .then((value) => {notifyListeners()});
  }

  int get oWNumOfChooseMeaning {
    if (prefs.getInt('_oWNumOfChooseMeaning') != null) {
      return prefs.getInt('_oWNumOfChooseMeaning')!;
    } else {
      return _oWNumOfChooseMeaning;
    }
  }

  // int oWMaxNumOfWords = 5;
  // int oWNumOfWritting = 5;
  // int oWMaxNumOfListening = 5;
  // int oWNumOfChooseWord = 5;
  // int oWNumOfChooseMeaning = 5;
  LearnProvider({
    this.failure,
  });

  Future eitherFailureOrSaveLearnedResult(
      List<int> wordIds, int vocabularySetId, List<int> memoryLevels) async {
    _isLoading = true;
    LearnRepositoryImpl repository = LearnRepositoryImpl(
      remoteDataSource: LearnRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: LearnLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSaveLearnedResult =
        await SaveLearnedResultUsecase(learnRepository: repository).call(
      saveLearnedResultParams: SaveLearnedResultParams(
          wordIds: wordIds,
          vocabularySetId: vocabularySetId,
          memoryLevels: memoryLevels,
          accessToken: await SecureStorageService.secureStorage
                  .read(key: 'accessToken') ??
              ''),
    );

    failureOrSaveLearnedResult.fold(
      (Failure newFailure) {
        _isLoading = false;
        saveResults = [];
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<List<UserLearnedWordEntity>> newVocaSet) {
        _isLoading = false;
        saveResults = newVocaSet.data;
        message = newVocaSet.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrCreReviewReminder(
      int vocabularySetId, List<DataRemindParams> data) async {
    _isLoading = true;
    LearnRepositoryImpl repository = LearnRepositoryImpl(
      remoteDataSource: LearnRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: LearnLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrCreReviewReminder =
        await CreReviewReminderUsecase(learnRepository: repository).call(
      creReviewReminderParams: CreReviewReminderParams(
          vocabularySetId: vocabularySetId,
          data: data,
          accessToken: await SecureStorageService.secureStorage
                  .read(key: 'accessToken') ??
              ''),
    );

    failureOrCreReviewReminder.fold(
      (Failure newFailure) {
        _isLoading = false;
        createdReviewReminder = null;
        failure = newFailure;
        message = newFailure.errorMessage;
        notifyListeners();
      },
      (ResponseDataModel<ReviewReminderEntity> newReviewReminder) {
        _isLoading = false;
        createdReviewReminder = newReviewReminder.data;
        message = newReviewReminder.message;
        failure = null;
        notifyListeners();
      },
    );
  }
}
