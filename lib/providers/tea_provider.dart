import 'package:flutter/cupertino.dart';
import 'package:tea_app/models/tea_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeaProvider extends ChangeNotifier {
  TeaModel _teaModel;
  TeaModel get teaModel => _teaModel;
  Map<String, List<TeaModel>> teas = {};

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
        print(list.length);
        return teas[place];
      }
    } catch (error) {
      print(error);
    }
    return [];
  }
}
