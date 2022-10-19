import 'package:sqflite/sqflite.dart'; 
import 'package:submission_tiga_notif/data/model/restaurant_favorite.dart';  
 
class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  
  static late Database _database;
 
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }
 
  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();
 

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }
 
  static const String _tableName = 'favorite'; 
 
 static Future<Database> _initializeDb() async {
    var path = await getDatabasesPath(); 
    return openDatabase(("${path}favorite_db.db"), onCreate: (db, version) => _createDb(db), version: 1);
  }

  static void _createDb(Database db) {
    db.execute('''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT, 
               description TEXT, 
               pictureId TEXT, 
               city TEXT, 
               rating REAL
             )'''); 
  }
  
  Future<void> insertFavorite(RestaurantFavorite favorite) async {
    final Database db = await database;
    await db.insert(_tableName, favorite.toMap()); 
  }
 
  Future<List<RestaurantFavorite>> getFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
  
    return results.map((res) => RestaurantFavorite.fromMap(res)).toList();
  }

  Future<RestaurantFavorite> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  
    return results.map((res) => RestaurantFavorite.fromMap(res)).first;
  }

  
  Future<bool> isFavorite(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  
    return Future<bool>.value(results.isNotEmpty);
  } 

  Future<void> deleteFavorite(String id) async {
    final db = await database;
  
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  } 
}


 