import 'package:flutter/foundation.dart';
import 'package:tea_app/database/favDB.dart';
import 'package:tea_app/models/tea_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<TeaModel> _favorites = [];
  List<TeaModel> get favorites => _favorites;

  FavoriteProvider() {
    _initFavorites();
  }

  Future<void> _initFavorites() async {
    _favorites.addAll(await Dbfav.getFavorites());
    notifyListeners();
  }

  Future<TeaModel> addToFavorite(TeaModel favoriteModel) async {
    TeaModel insertedModel = await Dbfav.insertFavorite(favoriteModel);
    _favorites.add(insertedModel);
    notifyListeners();
  }

  Future<void> deleteFromFavorite(TeaModel favoriteModel) async {
    _favorites.remove(favoriteModel);
    await Dbfav.deleteFavorite(favoriteModel);
    notifyListeners();
  }

  Future<void> deleteById(int id) async {
    _favorites.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
