import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences() {
    return _instance;
  }

  static const dolar = '0';
  static const pound = '1';
  static const zloty = '2';
  static const euro = '3';

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setCurrency(String value) {
    return _prefs.setString('currency', value);
  }

  String getCurrency() {
    return _prefs.getString('currency') ?? 'USD';
  }

  Future<bool> setLang(String value) {
    return _prefs.setString('lang', value);
  }

  String getLang() {
    return _prefs.getString('lang') ?? 'en';
  }
}
