import 'package:flutter/foundation.dart';
import 'package:tea_app/database/cartDB.dart';
import 'package:tea_app/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> _cart = [];

  List<CartModel> get cart => _cart;

  CartProvider() {
    _initCart();
  }

  Future<void> _initCart() async {
    _cart.addAll(await Db.getCartList());
    notifyListeners();
  }

  Future<CartModel> addToCart(CartModel cartModel) async {
    CartModel insertedModel = await Db.insertToCart(cartModel);
    _cart.add(insertedModel);
    notifyListeners();
  }

  Future<void> deleteFromCart(CartModel cartModel) async {
    _cart.remove(cartModel);
    await Db.deleteFromCart(cartModel);
    notifyListeners();
  }

  Future<void> deleteById(int id) async {
    _cart.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> deleteAllItems() async {
    _cart.clear();
    await Db.deleteAllItems();
    notifyListeners();
  }

  Future<void> updateById(CartModel cartModel, amount) async {
    int index = _cart.indexWhere((element) => element.name == cartModel.name);
    int count = _cart[index].count;
    int result = count + amount;
    if (index != -1) {
      _cart[index].name = cartModel.name;
      _cart[index].count = result;
      _cart[index].imgURL = cartModel.imgURL;
      _cart[index].price = cartModel.price;
    }

    await Db.updateByID(
        cartModel.name, cartModel.price, result, cartModel.imgURL);
    notifyListeners();
  }

  Future<void> changeCountOfItem(CartModel cartModel, amount) async {
    int index = _cart.indexWhere((element) => element.name == cartModel.name);
    if (index != -1) {
      _cart[index].name = cartModel.name;
      _cart[index].count = amount;
      _cart[index].imgURL = cartModel.imgURL;
      _cart[index].price = cartModel.price;
    }

    await Db.updateByID(
        cartModel.name, cartModel.price, amount, cartModel.imgURL);
    notifyListeners();
  }

  int getCountOfCart() {
    return _cart.length;
  }
}
