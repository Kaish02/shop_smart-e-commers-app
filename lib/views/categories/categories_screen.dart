import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/cart_model.dart';
import '../../providers/api_category_provider.dart';
import '../../providers/api_product_get_provider.dart';
import '../../providers/cart_provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ApiProductGetProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ===== Screen Header =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== Horizontal Category List =====
            SizedBox(
              height: 45,
              child: Consumer<ApiCategoryProvider>(
                builder: (context, categoryProvider, child) {
                  if (categoryProvider.isLoading) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 100,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProvider.categoriesList.length,
                    itemBuilder: (context, index) {
                      final category = categoryProvider.categoriesList[index];
                      bool isSelected =
                          categoryProvider.selectedCategory == category;

                      return GestureDetector(
                        onTap: () {
                          categoryProvider.selectCategory(category);
                          Provider.of<ApiProductGetProvider>(context,
                              listen: false)
                              .getProductsByCategory(category);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                              colors: [Colors.deepPurple, Colors.purpleAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                                : null,
                            color:
                            isSelected ? null : Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.deepPurple.shade200, width: 1.5),
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: Colors.deepPurple.shade100,
                                blurRadius: 6,
                                offset: const Offset(2, 2),
                              ),
                            ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color:
                                isSelected ? Colors.white : Colors.deepPurple,
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

            const SizedBox(height: 16),

            // ===== Products Grid =====
         Expanded(
           child: GridView.builder(
         padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: products.productsList?.length ?? 0,
        itemBuilder: (context, index) {
          final product = products.productsList?[index];
          var cartItem = CartItem(
            id: product?.id,
            title: product!.title.toString(),
            image: product.thumbnail.toString(),
            price: product.price.toDouble(),
            quantity: 1,
          );

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Product Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                         "${product?.thumbnail}",
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          "${product?.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Rating
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: product?.rating.toDouble(),
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
                                product?.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Rating
                          // Price Row


                          Row(
                            children: [
                              Text(
                                "₹${product?.price.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "${product?.discountPercentage.toStringAsFixed(0)}% Off",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),
                          Text(
                            "₹${product?.price}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration:
                              TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Positioned Add Button (outside corner)
              Positioned(
                bottom: -1,
                right: -1,
                child: GestureDetector(
                  onTap: () async {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false);

                    CartItem newItem = CartItem(
                      id: product.id,
                      title: product.title ?? "No title",
                      image: product.thumbnail ?? "",
                      price: (product.price is int) ? (product.price as int).toDouble() : (product.price as double),
                      quantity: 1,
                    );

                    await cartProvider.addToCart(newItem);

                    // 👇 Show SnackBar after adding to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${product.title} added to cart"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(18),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),

            ],
          );
        },
      ),
         )
    ],
        ),
      ),
    );
  }
}
