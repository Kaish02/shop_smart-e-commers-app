import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopsmart/views/product_details/product_detail_screen.dart';

import '../../models/cart_model.dart';
import '../../models/product.dart';
import '../../providers/api_category_provider.dart';
import '../../providers/api_product_get_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorites_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ApiCategoryProvider>(context, listen: false)
            .getCategories());
  }

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // light elegant bg
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB5B5FB), // light grey
              Colors.white, // bottom white
            ],
            stops: [0.1, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ApiProductGetProvider>(
              builder: (context, provider, child) {
                final products = provider.productsList;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // greeting
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurple.shade400),
                              ),
                              const Text(
                                "ShopSmart User",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A237E)), // dark blue-grey
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/profile_image/k2.jpg"),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.shopping_cart,
                                    size: 26,
                                    color: Color(0xFFFF6F00)), // deep orange
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15),

                      // search bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search,
                                color: Colors.deepPurple.shade300),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  if (_debounce?.isActive ?? false)
                                    _debounce!.cancel();
                                  _debounce = Timer(
                                      const Duration(milliseconds: 300), () {
                                    if (value.isNotEmpty) {
                                      Provider.of<ApiProductGetProvider>(
                                          context,
                                          listen: false)
                                          .searchProducts(value);
                                    } else {
                                      Provider.of<ApiProductGetProvider>(
                                          context,
                                          listen: false)
                                          .getProductApiData();
                                    }
                                  });
                                },
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    Provider.of<ApiProductGetProvider>(context,
                                        listen: false)
                                        .searchProducts(value);
                                  } else {
                                    Provider.of<ApiProductGetProvider>(context,
                                        listen: false)
                                        .getProductApiData();
                                  }
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  hintText: "Search products",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Icon(Icons.filter_list,
                                color: Color(0xFFFF6F00)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Categories Section
                      SizedBox(
                        height: 45,
                        child: Consumer<ApiCategoryProvider>(
                          builder: (context, categoryProvider, child) {
                            if (categoryProvider.isLoading) {
                              // Shimmer effect instead of CircularProgressIndicator
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5, // number of shimmer placeholders
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade200,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                            if (categoryProvider.categoriesList.isEmpty) {
                              return const Center(child: Text("No categories found"));
                            }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryProvider.categoriesList.length,
                              itemBuilder: (context, index) {
                                final category = categoryProvider.categoriesList[index];
                                return GestureDetector(
                                  onTap: () {
                                    categoryProvider.selectCategory(category);
                                    Provider.of<ApiProductGetProvider>(context, listen: false)
                                        .getProductsByCategory(category);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 6),
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade50,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.deepPurple.shade200,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 5),
                      Container(
                        height: 140,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB9B3B), // yellow background
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Side Text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Super Sale",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Shop now",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            // Right Side Phone Image
                            Image.network(
                              "https://cdn-icons-png.flaticon.com/512/814/814513.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),

                      // section header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Featured",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.indigo.shade900)),
                          const Text(
                            "See All",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFFFF6F00)),
                          )
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Featured products list
                      SizedBox(
                        height: 190,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products?.length ?? 0,
                          itemBuilder: (context, index) {
                            final product = products![index];
                            return GestureDetector(
                              onTap: () {
                                // Navigate to product details screen
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(title: product.title ?? "", description: product.description ?? "", price: product.price ?? 0.0, rating: product.rating ?? 0.0,       images: [product.thumbnail ?? ""],)));
                              },
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image + Heart icon
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(16),
                                          ),
                                          child: Image.network(
                                            product.thumbnail ?? "",
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Consumer<FavoritesProvider>(
                                            builder: (context, favoritesProvider, _) {
                                              final isFav = favoritesProvider.isFavorite(product.id!.toInt());

                                              return GestureDetector(
                                                onTap: () {
                                                  if (isFav) {
                                                    favoritesProvider.removeFromFavorites(product.id!.toInt());
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("${product.title} removed from favorites ❌"),
                                                        duration: const Duration(seconds: 1),
                                                      ),
                                                    );
                                                  } else {
                                                    /// ✅ Yahan product object pass karo
                                                    favoritesProvider.addToFavorites(Product(
                                                      id: product.id!.toInt(),
                                                      title: product.title ?? "",
                                                      price: product.price.toString(),
                                                      image: product.thumbnail ?? "",
                                                    ));

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("${product.title} added to favorites ❤️"),
                                                        duration: const Duration(seconds: 1),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 6,
                                                      )
                                                    ],
                                                  ),
                                                  child: Icon(
                                                    isFav ? Icons.favorite : Icons.favorite_border,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),


                                    // Title + Price
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(product.title ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87)),
                                          const SizedBox(height: 4),
                                          Text("₹${product.price.toInt()}",
                                              style: const TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Text("Most Popular",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 10),

                      // Grid products
                      GridView.builder(
                        itemCount: products?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, index) {
                          final product = products![index];
                          int discount = product.discountPercentage!.toInt();
                          double oldPrice = product.price!.toDouble();
                          double newPrice =
                              oldPrice - (oldPrice * discount / 100);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(title: product.title ?? "", description: product.description ?? "", price: product.price ?? 0.0, rating: product.rating ?? 0.0,       images: [product.thumbnail ?? ""],)));},
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        // Image
                                        ClipRRect(
                                          borderRadius:
                                          const BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                          child: Image.network(
                                            product.thumbnail.toString(),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),

                                        // Add to Cart Button (Top Right)
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Container(
                                            height: 43,
                                            decoration: const BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  offset: Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.add_shopping_cart,
                                                size: 20,
                                                color: Colors.deepPurple,
                                              ),
                                              onPressed: () async {
                                                final cartProvider = Provider.of<CartProvider>(context, listen: false);

                                                final newItem = CartItem(
                                                  title: product.title.toString(),
                                                  image: product.thumbnail.toString(),
                                                  price: product.price.toDouble(),
                                                  quantity: 1,
                                                );

                                                await cartProvider.addToCart(newItem);

                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text("${product.title} added to cart"),
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                  // Product details
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // Brand
                                        Text(
                                          product.brand?.toUpperCase() ??
                                              "Unknown",
                                          style: TextStyle(
                                            color: Colors.indigo.shade700,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 2),

                                        // Title
                                        Text(
                                          product.title.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        const SizedBox(height: 6),

                                        // Price Row
                                        Row(
                                          children: [
                                            Text(
                                              "₹${newPrice.toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "₹${oldPrice.toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                decoration:
                                                TextDecoration.lineThrough,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "$discount% OFF",
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),

                                        // Rating
                                        Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: product.rating!.toDouble(),
                                              itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                              ),
                                              itemCount: 5,
                                              itemSize: 18,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              product.rating!.toStringAsFixed(1),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
