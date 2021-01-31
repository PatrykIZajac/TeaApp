import 'package:tea_app/models/tea_model.dart';

class CartModel {
  int id;
  String name;
  double price;
  int count;
  String imgURL;

  CartModel({this.id, this.name, this.price, this.count, this.imgURL});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'count': count,
      'imgURL': imgURL
    };
  }

  static List<CartModel> fromMap(List<Map<String, dynamic>> map) {
    return List.generate(map.length, (i) {
      return CartModel(
        id: map[i]['id'],
        name: map[i]['name'],
        price: map[i]['price'],
        count: map[i]['count'],
        imgURL: map[i]['imgURL'],
      );
    });
  }

  static CartModel fromWeatherModel(TeaModel teaModel) {
    return CartModel(
      name: teaModel.name,
      price: teaModel.price,
      imgURL: teaModel.imgURL,
    );
  }
}
