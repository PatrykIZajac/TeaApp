import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tea_app/models/tea_model.dart';

class Dbfav {
  static Dbfav _instance = Dbfav._internal();
  Database _database;

  static final String tableFavorite = 'Favorite';

  factory Dbfav() {
    return _instance;
  }

  Dbfav._internal() {}

  init() async {
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
    teaModel.id = await Dbfav().getDatabase().insert(
        tableFavorite, teaModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail);
    return teaModel;
  }

  static Future<int> deleteFavorite(TeaModel favoriteModel) async {
    return deleteById(favoriteModel.id);
  }

  static Future<List<TeaModel>> getFavorites() async {
    return TeaModel.fromMap(await Dbfav().getDatabase().query(tableFavorite));
  }

  static Future<int> deleteById(int id) async {
    return await Dbfav()
        .getDatabase()
        .delete(tableFavorite, where: 'id=?', whereArgs: [id]);
  }
}
