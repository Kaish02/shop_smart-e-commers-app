import 'package:sqflite/sqflite.dart';

import '../models/product.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final dbPath = '$path/app.db';

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE wishlist_table (
            id INTEGER PRIMARY KEY,
            title TEXT,
            price TEXT,
            image TEXT,
            isFav INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Product>> getWishlist() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient.query('wishlist_table');
    return result.map((e) => Product.fromMap(e)).toList();
  }

  Future<void> insertToWishlist(Product product) async {
    final dbClient = await db;
    await dbClient.insert('wishlist_table', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFromWishlist(int id) async {
    final dbClient = await db;
    await dbClient.delete('wishlist_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isInWishlist(int id) async {
    final dbClient = await db;
    final result = await dbClient.query('wishlist_table', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
