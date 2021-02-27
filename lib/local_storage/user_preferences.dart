import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences() {
    return _instance;
  }

  static const dolar = 'USD';
  static const pound = 'GBP';
  static const zloty = 'PLN';
  static const euro = 'Euro';

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
