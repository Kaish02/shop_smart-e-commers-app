import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/cart_model.dart';

class CartDBHelper {
  static final CartDBHelper _instance = CartDBHelper._internal();
  factory CartDBHelper() => _instance;
  CartDBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            image TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertCartItem(CartItem item) async {
    final database = await db;

    // Check if item already exists
    final existing = await database.query(
      'cart',
      where: 'id = ?',
      whereArgs: [item.id],
    );

    if (existing.isNotEmpty) {
      // Update quantity instead of inserting
      final existingItem = existing.first;
      int currentQuantity = existingItem['quantity'] as int;
      await database.update(
        'cart',
        {'quantity': currentQuantity + item.quantity},
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } else {
      // Safe to insert
      await database.insert('cart', item.toMap());
    }
  }


  Future<List<CartItem>> getCartItems() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('cart');
    return maps.map((e) => CartItem.fromMap(e)).toList();
  }

  Future<int> deleteCartItem(int id) async {
    final dbClient = await db;
    return await dbClient.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCartItem(CartItem item) async {
    final dbClient = await db;
    return await dbClient.update('cart', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }


  Future<void> clearCart() async {
    final dbClient = await db;
    await dbClient.delete('cart');
  }
}
