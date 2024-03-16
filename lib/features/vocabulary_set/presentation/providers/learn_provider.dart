import 'package:ctue_app/core/services/shared_pref_service.dart';
import 'package:flutter/material.dart';

class LearnProvider extends ChangeNotifier {
  final prefs = SharedPrefService.prefs;

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
}
