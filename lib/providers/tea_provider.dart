import 'package:flutter/cupertino.dart';
import 'package:tea_app/local_storage/user_preferences.dart';
import 'package:tea_app/models/tea_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeaProvider extends ChangeNotifier {
  TeaModel _teaModel;
  TeaModel get teaModel => _teaModel;
  Map<String, List<TeaModel>> teas = {};
  TeaModel specificTea;

  Future<List<TeaModel>> getListOfTeasByCountryName(String place,
      [forceDownload = false]) async {
    if (!forceDownload && teas.containsKey(place)) {
      return teas[place];
    }
    try {
      final response =
          await http.get('http://77.55.194.14:4040/tea/country/$place');
      if (response.statusCode == 200) {
        List<TeaModel> list = [];
        final json = jsonDecode(response.body);
        if (json != null) {
          json.forEach((element) {
            final teaModel = TeaModel.fromJson(element);
            list.add(teaModel);
          });
        }
        teas[place] = list;
        // print(list.length);
        return teas[place];
      }
    } catch (error) {
      print(error);
    }
    return [];
  }

  getTeaByName(name) async {
    try {
      final response =
          await http.get('http://77.55.194.14:4040/tea/search/one/${name}');
      specificTea = TeaModel.fromJson(jsonDecode(response.body));
      return specificTea;
    } catch (error) {
      print("Nie ma takiej herbaty");
    }
  }

  String getCurrency(double price) {
    if (UserPreferences().getCurrency() == UserPreferences.dolar) {
      String result = "$price \u{0024}";
      return result;
    }
    if (UserPreferences().getCurrency() == UserPreferences.zloty) {
      double zloty = price * 3.74;
      String result = "${zloty.toStringAsFixed(2)}  PLN";
      return result;
    }
    if (UserPreferences().getCurrency() == UserPreferences.pound) {
      double pound = price * 0.72;
      String result = "${pound.toStringAsFixed(2)}  \u{20A4}";
      return result;
    }
    if (UserPreferences().getCurrency() == UserPreferences.euro) {
      double euro = price * 0.83;
      String result = "${euro.toStringAsFixed(2)} \u{20AC}";
      return result;
    }
  }
}
