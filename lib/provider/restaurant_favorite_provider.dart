import 'package:flutter/foundation.dart';
import 'package:submission_tiga_notif/data/database_local/database_helper.dart';
import 'package:submission_tiga_notif/data/model/restaurant_favorite.dart'; 

class RestaurantFavoriteProvider extends ChangeNotifier {
  List<RestaurantFavorite> _favorites = [];
  bool _isPavorite = false; 
 
  late DatabaseHelper _dbHelper;
 
  List<RestaurantFavorite> get favorites => _favorites;
  bool get isPavorite => _isPavorite;
 
  RestaurantFavoriteProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorites();
  }

  void _getAllFavorites() async {
    _favorites = await _dbHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(RestaurantFavorite favorite) async {
    await _dbHelper.insertFavorite(favorite);
    _getAllFavorites();
  }

  Future<RestaurantFavorite> getFavoriteById(String id) async {
    return await _dbHelper.getFavoriteById(id);
  } 
  
  void deleteFavorite(String id) async {
    await _dbHelper.deleteFavorite(id);
    _getAllFavorites();
  }

  Future<void> isFavorite(String id) async {
    _isPavorite = await _dbHelper.isFavorite(id);
    notifyListeners();
  }
  
}
