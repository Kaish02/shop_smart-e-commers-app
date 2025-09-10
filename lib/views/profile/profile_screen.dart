import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../address/shoping_address.dart';
import '../favorites/favorites_screen.dart';
import '../login/login_screen.dart';
import '../orders/orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Gradient Header =====
            Container(
              height: 220,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar with Gradient Border
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.pink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage("assets/profile_image/k3.jpg"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Kaish",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "kkaish845@gmail.com",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileStatCard(
                    title: "Orders",
                    value: "12",
                    gradientColors: [Colors.blue, Colors.lightBlueAccent],
                  ),
                  ProfileStatCard(
                    title: "Favorites",
                    value: "8",
                    gradientColors: [Colors.pink, Colors.redAccent],
                  ),
                  ProfileStatCard(
                    title: "Points",
                    value: "120",
                    gradientColors: [Colors.green, Colors.teal],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ProfileOption(
                    icon: Icons.shopping_cart,
                    title: "My Orders",
                    gradientColors: const [Colors.blue, Colors.lightBlueAccent],
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersScreen(),));
                    },
                  ),
                  ProfileOption(
                    icon: Icons.favorite,
                    title: "Favorites",
                    gradientColors: const [Colors.pink, Colors.redAccent],
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen(),));
                    },
                  ),
                  ProfileOption(
                    icon: Icons.location_on,
                    title: "Address",
                    gradientColors: const [Colors.teal, Colors.greenAccent],
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopingAddress(),));
                    },
                  ),
                  ProfileOption(
                    icon: Icons.logout,
                    title: "Logout",
                    gradientColors: const [Colors.red, Colors.orange],
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Gradient Logout Icon
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [Colors.red, Colors.orange],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.logout,
                                        color: Colors.white, size: 40),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Confirm Logout",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Are you sure you want to logout from ShopSmart?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  const SizedBox(height: 24),

                                  // Buttons Row
                                  Row(
                                    children: [
                                      // Cancel Button
                                      // Cancel Button (highlighted)
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            elevation: 3,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            // light highlight
                                            foregroundColor: Colors.black87,
                                            shadowColor: Colors.black26,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),
                                      // Logout Button with Gradient
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            elevation: 3,
                                            backgroundColor: Colors.transparent,
                                            // gradient will cover
                                            shadowColor: Colors.black26,
                                          ),
                                          onPressed: () async {
                                            var sharedPref =
                                                await SharedPreferences
                                                    .getInstance();
                                            await sharedPref.remove("token");

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()),
                                            );
                                          },
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.red,
                                                  Colors.orange
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              child: const Text(
                                                "Logout",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    isDestructive: true,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Profile Stats Card =====
class ProfileStatCard extends StatelessWidget {
  final String title;
  final String value;
  final List<Color> gradientColors;

  const ProfileStatCard({
    super.key,
    required this.title,
    required this.value,
    this.gradientColors = const [Colors.deepPurple, Colors.purpleAccent],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: (MediaQuery.of(context).size.width - 48) / 3, // equal width
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Profile Option Card =====
class ProfileOption extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;
  final List<Color> gradientColors;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
    this.gradientColors = const [Colors.deepPurple, Colors.purpleAccent],
  });

  @override
  State<ProfileOption> createState() => _ProfileOptionState();
}

class _ProfileOptionState extends State<ProfileOption>
    with SingleTickerProviderStateMixin {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.95),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      onTap: widget.onTap,
      child: Transform.scale(
        scale: scale,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
              ),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                color: widget.isDestructive ? Colors.red : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
