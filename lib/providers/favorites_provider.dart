import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/wishlist_db_helper.dart';


class FavoritesProvider with ChangeNotifier {
  List<Product> _favorites = [];
  final DBHelper _dbHelper = DBHelper();

  List<Product> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await _dbHelper.getWishlist();
    notifyListeners();
  }

  Future<void> addToFavorites(Product product) async {
    await _dbHelper.insertToWishlist(product);
    await loadFavorites();
  }

  Future<void> removeFromFavorites(int id) async {
    await _dbHelper.removeFromWishlist(id);
    await loadFavorites();
  }

  bool isFavorite(int id) {
    return _favorites.any((item) => item.id == id);
  }
}
