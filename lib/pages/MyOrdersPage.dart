import 'package:flutter/material.dart';
import '../widgets/HomeAppBar.dart';
import 'package:agri_fresh/api/order_api.dart';

class MyOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(120),
      //   child: HomeAppBar(),
      // ),
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
                  'My Orders',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Current Orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.local_shipping, color: Colors.green),
                    title: const Text('Order #1234 - Organic Rice'),
                    subtitle: const Text('Placed on May 20, 2025 | Total: \$15.99'),
                    trailing: const Text('In Transit', style: TextStyle(color: Colors.orange)),
                    onTap: () {
                      // Navigate to order details (future implementation)
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
            const Text(
              'Order History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: const Text('Order #1233 - Fresh Vegetables'),
                    subtitle: const Text('Delivered on May 15, 2025 | Total: \$8.49'),
                    trailing: const Text('Delivered', style: TextStyle(color: Colors.green)),
                    onTap: () {
                      // Navigate to order details (future implementation)
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: const Text('Order #1232 - Organic Fruits'),
                    subtitle: const Text('Delivered on May 10, 2025 | Total: \$12.99'),
                    trailing: const Text('Delivered', style: TextStyle(color: Colors.green)),
                    onTap: () {
                      // Navigate to order details (future implementation)
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}