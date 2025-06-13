import 'package:flutter/material.dart';
import '../widgets/HomeAppBar.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'More',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // My Profile Section
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: const Text(
                'My Profile',
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, '/my-profile-page');
              },
            ),
            const Divider(),
            // Wishlist Section
            ListTile(
              leading: const Icon(Icons.favorite_border, color: Colors.green),
              title: const Text(
                'Wishlist',
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, '/wishlist-page');
              },
            ),
            const Divider(),
            // Become a Seller Section
            ListTile(
              leading: const Icon(Icons.store, color: Colors.green),
              title: const Text(
                'Become a Seller',
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, '/become-seller-page');
              },
            ),
            const Divider(),
            // Cart Section
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.green),
              title: const Text(
                'Cart',
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, 'CartPage');
              },
            ),
            const Divider(),
            // My Orders Section
            ListTile(
              leading: const Icon(Icons.history, color: Colors.green),
              title: const Text(
                'My Orders',
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, '/my-orders-page');
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}