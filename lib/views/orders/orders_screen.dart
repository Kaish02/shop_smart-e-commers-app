import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "id": "#ORD12345",
        "date": "30 Aug 2025",
        "status": "Delivered",
        "amount": "\$45.99",
        "items": ["Bananas 🍌", "Coffee ☕"]
      },
      {
        "id": "#ORD12346",
        "date": "28 Aug 2025",
        "status": "Pending",
        "amount": "\$25.50",
        "items": ["Broccoli 🥦", "Mandarin 🍊"]
      },
      {
        "id": "#ORD12347",
        "date": "25 Aug 2025",
        "status": "Cancelled",
        "amount": "\$19.99",
        "items": ["Cherries 🍒"]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID + Status Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "dfsdfds",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: order["status"] == "Delivered"
                              ? Colors.green.withOpacity(0.2)
                              : order["status"] == "Pending"
                              ? Colors.orange.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "ghdsgfhds",
                          style: TextStyle(
                            color: order["status"] == "Delivered"
                                ? Colors.green
                                : order["status"] == "Pending"
                                ? Colors.orange
                                : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Date & Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "xdzdsda",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "fcgxgdzf",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  const Divider(),

                  // Items
                  Wrap(
                    spacing: 8,
                    children: List.generate(
                      (order["items"] as List).length,
                          (i) => Chip(
                        label: Text("d"),
                        backgroundColor: Colors.grey.shade100,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("View Details →"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
