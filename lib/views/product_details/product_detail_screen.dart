import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String> images;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedImage = 0;
  int quantity = 1;
  String selectedSize = 'M';
  Color selectedColor = Colors.green;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.blue,
    Colors.green,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    // final formattedPrice =
    // NumberFormat("#,##0", "en_US").format(widget.price * quantity);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {}),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- IMAGE ----------
                  SizedBox(
                    height: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(widget.images.length, (index) {
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => selectedImage = index),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedImage == index
                                        ? Color(0xF01A237E)
                                        : Colors.grey.shade300,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  widget.images[index],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Image.network(
                            widget.images[selectedImage],
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ---------- TITLE & RATING ----------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.orange.shade400, size: 18),
                            const SizedBox(width: 4),
                            Text("${widget.rating} Ratings",
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(width: 15),
                            const Text("1.3k Reviews",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---------- SIZE ----------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Size",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        Row(
                          children: sizes.map((size) {
                            final isSelected = selectedSize == size;
                            return GestureDetector(
                              onTap: () => setState(() => selectedSize = size),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green
                                      : Colors.transparent,
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.green
                                          : Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(size,
                                    style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ---------- COLOUR ----------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Colour",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        Row(
                          children: colors.map((color) {
                            final isSelected = selectedColor == color;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => selectedColor = color),
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check,
                                        size: 16, color: Colors.white)
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---------- DESCRIPTION ----------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(widget.description,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 14)),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ---------- PRICE + QUANTITY + BUY BUTTON ----------
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.white10,
                  offset: const Offset(0, 1),
                )
              ],
              color: Colors.green.shade100.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Rs. ${widget.price}",
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xF01A237E))),
                    const SizedBox(width: 8),
                    Text("Rs. 3,499",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey)),

                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text(quantity.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () => setState(() => quantity++),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {},
                        child: const Text("Add To Cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {},
                        child: const Text("Buy Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String> images;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedImage = 0;
  int quantity = 1;
  int selectedTab = 0; // 0 = About Item, 1 = Reviews

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {}),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ---------- IMAGE + THUMBNAILS ----------
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Thumbnails
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(widget.images.length, (index) {
                          return GestureDetector(
                            onTap: () => setState(() => selectedImage = index),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedImage == index ? Colors.green : Colors.grey.shade300,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                widget.images[index],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      // Main Image
                      Expanded(
                        child: Image.network(
                          widget.images[selectedImage],
                          fit: BoxFit.cover,
                          height: 250,
                        ),
                      ),
                    ],
                  ),
                ),

                // ---------- TITLE ----------
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange.shade400, size: 18),
                          const SizedBox(width: 4),
                          Text("${widget.rating} Ratings",
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(width: 15),
                          const Text("2.3k Reviews • 2.1k+ Sold",
                              style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),

                // ---------- TABS ----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text("About Item"),
                      selected: selectedTab == 0,
                      onSelected: (_) => setState(() => selectedTab = 0),
                    ),
                    const SizedBox(width: 10),
                    ChoiceChip(
                      label: const Text("Reviews"),
                      selected: selectedTab == 1,
                      onSelected: (_) => setState(() => selectedTab = 1),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // ---------- TAB CONTENT ----------
                if (selectedTab == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(widget.description,
                        style: const TextStyle(color: Colors.black87, fontSize: 14)),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("⭐ 4.9 - Amazing product, highly recommended!",
                        style: TextStyle(color: Colors.black87, fontSize: 14)),
                  ),
              ],
            ),
          ),

          // ---------- PRICE + QUANTITY + BUTTON ----------
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("\$${widget.price}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) setState(() => quantity--);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text(quantity.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () => setState(() => quantity++),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Text("Buy Now", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Text("Add to Cart", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

 */

/*import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String> images;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentIndex = 0;
  String selectedSize = "M";
  String selectedColor = "Blue";
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 Image Carousel
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 350,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: widget.images.map((img) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.images.map((url) {
                        int index = widget.images.indexOf(url);
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.green
                                : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              // 🔥 Product Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("\$${widget.price}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),

                    const SizedBox(height: 16),

                    // 🔥 Size Selection
                    Row(
                      children: ["S", "M", "L", "XL"].map((size) {
                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedSize = size);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedSize == size
                                  ? Colors.green
                                  : Colors.grey.shade200,
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: selectedSize == size
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // 🔥 Color Selection
                    Row(
                      children: ["Blue", "Black", "Red"].map((color) {
                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedColor = color);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedColor == color
                                  ? Colors.green
                                  : Colors.grey.shade300,
                            ),
                            child: Text(
                              color[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // 🔥 Quantity Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text("$quantity",
                                style: const TextStyle(fontSize: 18)),
                            IconButton(
                              onPressed: () {
                                setState(() => quantity++);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {},
                          child: const Text("Add to Cart",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔥 Description
                    const Text("Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(widget.description,
                        style: TextStyle(color: Colors.grey[700])),

                    const SizedBox(height: 20),

                    // 🔥 You Might Also Like
                    const Text("You might also like",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_bag,
                                    size: 50, color: Colors.grey),
                                const SizedBox(height: 5),
                                Text("Item $index",
                                    style:
                                    const TextStyle(color: Colors.black)),
                                const Text("\$40",
                                    style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
