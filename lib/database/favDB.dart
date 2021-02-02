import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tea_app/models/tea_model.dart';

class DbFav {
  static DbFav _instance = DbFav._internal();
  Database _database;

  static final String tableFavorite = 'Favorite';

  factory DbFav() {
    return _instance;
  }

  DbFav._internal() {}

  init() async {
    print("INIT");
    _database = await openDatabase(
        join(await getDatabasesPath(), 'databaseFav.db'),
        version: 1, onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE $tableFavorite (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, price DOUBLE, imgURL STRING, brewTime STRING, brewTemp INT, originCountry STRING, description STRING)');
    });
  }

  Database getDatabase() {
    if (_database == null) {
      throw Exception('Call init() first!');
    }
    return _database;
  }

  static Future<TeaModel> insertFavorite(TeaModel teaModel) async {
    teaModel.id = await DbFav().getDatabase().insert(
        tableFavorite, teaModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail);
    print('DB ADDED');
    return teaModel;
  }

  static Future<int> deleteById(int id) async {
    print('DB DELETE 2');
    return await DbFav()
        .getDatabase()
        .delete(tableFavorite, where: 'id=?', whereArgs: [id]);
  }

  static Future<int> deleteFavorite(TeaModel favoriteModel) async {
    print('DB DELETE 1');
    return deleteById(favoriteModel.id);
  }

  static Future<List<TeaModel>> getFavorites() async {
    return TeaModel.fromMap(await DbFav().getDatabase().query(tableFavorite));
  }
}
