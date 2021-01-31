import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tea_app/models/cart_model.dart';

class Db {
  static Db _instance = Db._internal();
  Database _database;

  static final String tableCart = 'Cart';

  factory Db() {
    return _instance;
  }

  Db._internal() {}

  init() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), 'database.db'),
        version: 1, onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE $tableCart (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, price DOUBLE, count INT, imgURL STRING)');
    });
  }

  Database getDatabase() {
    if (_database == null) {
      throw Exception('Call init() first!');
    }
    return _database;
  }

  static Future<CartModel> insertToCart(CartModel cartModel) async {
    cartModel.id = await Db().getDatabase().insert(tableCart, cartModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail);
    return cartModel;
  }

  static Future<int> deleteFromCart(CartModel cartModel) async {
    return deleteById(cartModel.id);
  }

  static Future<List<CartModel>> getCartList() async {
    return CartModel.fromMap(await Db().getDatabase().query(tableCart));
  }

  static Future<int> deleteById(int id) async {
    return await Db()
        .getDatabase()
        .delete(tableCart, where: 'id=?', whereArgs: [id]);
  }

  static Future deleteAllItems() async {
    return await Db().getDatabase().rawQuery('Delete FROM "Cart"');
  }

  static Future updateByID(
      String name, double price, int count, String imgURL) async {
    await Db().getDatabase().rawUpdate(
        'UPDATE Cart SET name = ?, price = ?, count = ?, imgURL = ? WHERE name = ?',
        [name, price, count, imgURL, name]);
  }
}
