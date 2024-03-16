import 'package:shared_preferences/shared_preferences.dart';

//Singleton Pattern
class SharedPrefService {
  static late SharedPreferences _prefs;

  static SharedPreferences get prefs => _prefs;

  SharedPrefService._internal();

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
