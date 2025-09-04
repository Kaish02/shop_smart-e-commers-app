import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../services/cart_db_helper.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    double total = 0;
    _items.forEach((item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  Future<void> loadCartItems() async {
    _items = await CartDBHelper().getCartItems();
    notifyListeners();
  }

  Future<void> addToCart(CartItem item) async {
    // Check if item already in cart
    int index = _items.indexWhere((element) => element.id == item.id);
    if (index >= 0) {
      // Update quantity
      _items[index].quantity += item.quantity;
      await CartDBHelper().updateCartItem(_items[index]);

    } else {
      await CartDBHelper().insertCartItem(item);
    }
    await loadCartItems();
  }


  Future<void> updateQuantity(int id, int qty) async {
    // Find the item in the current list
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      // Update quantity in the item object
      CartItem updatedItem = _items[index];
      updatedItem.quantity = qty;

      // Update in DB
      await CartDBHelper().updateCartItem(updatedItem);

      // Reload items from DB
      await loadCartItems();
    }
  }


  Future<void> removeFromCart(int id) async {
    await CartDBHelper().deleteCartItem(id);
    await loadCartItems();
  }

  Future<void> clearCart() async {
    await CartDBHelper().clearCart();
    await loadCartItems();
  }
}
