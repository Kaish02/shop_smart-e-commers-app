import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/api_authentication_provider.dart';
import 'package:shopsmart/providers/api_category_provider.dart';
import 'package:shopsmart/providers/api_product_get_provider.dart';
import 'package:shopsmart/providers/cart_provider.dart';
import 'package:shopsmart/providers/favorites_provider.dart';
import 'package:shopsmart/views/splash/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ApiAuthenticationProvider()),
    ChangeNotifierProvider(create: (context) => ApiProductGetProvider()),
    ChangeNotifierProvider(create: (context) => ApiCategoryProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => FavoritesProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

