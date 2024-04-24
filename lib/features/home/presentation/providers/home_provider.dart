import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/services/shared_pref_service.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  final prefs = SharedPrefService.prefs; // Access to SharedPreferences

  List<String> _recentPages = [];
  Failure? failure;

  List<String> get recentPages => _recentPages; // Getter for recentPages

  HomeProvider() {
    _loadRecentPages(); // Load initial recent pages
  }

  Future<void> saveRecentPage(String url) async {
    if (!_recentPages.contains(url)) {
      _recentPages.insert(0, url);
      if (_recentPages.length > 4) {
        _recentPages.removeLast();
      }
      await prefs.setStringList('recentPages', _recentPages);
      notifyListeners();
    }
  }

  Future<void> _loadRecentPages() async {
    _recentPages = prefs.getStringList('recentPages') ?? [];
    notifyListeners();
  }

  Future<void> removeRecentPages() async {
    recentPages.clear();
    prefs.remove('recentPages');
  }
}
