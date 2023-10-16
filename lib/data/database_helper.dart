import 'package:logger/logger.dart';
import 'package:dicoding_restaurant_app/models/restaurant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  Logger logger = Logger();

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT, 
               description TEXT, 
               pictureId TEXT, 
               city TEXT, 
               rating REAL
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toMap());
  }

  Future<List<Restaurant>> getRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Restaurant.fromMap(res)).toList();
  }

  Future<Restaurant?> findRestaurant(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) {
      return null; // Or throw an exception if you prefer
    }

    return results.map((res) => Restaurant.fromMap(res)).first;
  }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    final Database db = await database;

    await db.update(
      _tableName,
      restaurant.toMap(),
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<void> deleteRestaurant(String id) async {
    final Database db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

}