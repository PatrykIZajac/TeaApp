import 'package:tea_app/local_storage/user_preferences.dart';

class TeaModel {
  int id;
  String name;
  double price;
  String imgURL;
  String brewTime;
  int brewTemp;
  String originCountry;
  String description;

  TeaModel(
      {this.id,
      this.name,
      this.price,
      this.imgURL,
      this.brewTime,
      this.brewTemp,
      this.originCountry,
      this.description});

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imgURL': imgURL,
      'brewTime': brewTime,
      'brewTemp': brewTemp,
      'originCountry': originCountry,
      'description': description
    };
  }

  static List<TeaModel> fromMap(List<Map<String, dynamic>> map) {
    return List.generate(map.length, (i) {
      return TeaModel(
        id: map[i]['id'],
        name: map[i]['name'],
        price: map[i]['price'],
        imgURL: map[i]['imgURL'],
        brewTime: map[i]['brewTime'].toString(),
        brewTemp: map[i]['brewTemp'],
        originCountry: map[i]['originCountry'],
        description: map[i]['description'],
      );
    });
  }

  TeaModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    price = double.parse(json['price'].toString());
    imgURL = json['imgURL'];
    brewTime = json['brewTime'];
    brewTemp = int.parse(json['brewTemp'].toString());
    originCountry = json['originCountry'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imgURL'] = this.imgURL;
    data['brewTime'] = this.brewTime;
    data['brewTemp'] = this.brewTemp;
    data['originCountry'] = this.originCountry;
    data['description'] = this.description;
    return data;
  }
}
