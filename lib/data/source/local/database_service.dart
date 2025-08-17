import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const String _databaseName = "foodie_finder.db";
  static const String _tableName = "favorite";
  static const int _version = 1;

  Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        name VARCHAR(255) NOT NULL,
        description VARCHAR(255),
        pictureId VARCHAR(255),
        city VARCHAR(255) NOT NULL,
        rating FLOAT NOT NULL
      )
    ''');
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database db, int version) async {
        await createTables(db);
      },
    );
  }

  Future<List<Restaurant>> getAllFavorites() async {
    final db = await _initializeDb();

    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Restaurant.fromJson(maps[i]);
    });
  }

  Future<Restaurant?> getFavoriteById(String id) async {
    final db = await _initializeDb();

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Restaurant.fromJson(maps.first);
    }
    return null;
  }

  Future<int> addFavorite(Restaurant restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();

    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<int> removeFavorite(String id) async {
    final db = await _initializeDb();

    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
