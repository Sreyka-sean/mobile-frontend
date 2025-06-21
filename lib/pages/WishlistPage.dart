import 'package:flutter/material.dart';
import '../services/wishlist_service.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Future<List<Map<String, dynamic>>> _futureWishlist;

  @override
  void initState() {
    super.initState();
    _futureWishlist = WishlistService.fetchWishlist();
  }

  void _removeFromWishlist(int productId) async {
    await WishlistService.removeFromWishlist(productId);
    setState(() {
      _futureWishlist = WishlistService.fetchWishlist();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Removed from Wishlist!')),
    );
  }

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
                  'Wishlist',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureWishlist,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Your wishlist is empty.'));
                  }
                  final wishlistItems = snapshot.data!;
                  return ListView.builder(
                    itemCount: wishlistItems.length,
                    itemBuilder: (context, index) {
                      final item = wishlistItems[index];
                      return ListTile(
                        leading: item['image_url'] != null
                            ? Image.network(
                          item['image_url'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                            : Icon(Icons.image, size: 50),
                        title: Text(item['name'] ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['description'] ?? ''),
                            Text('\$${item['price'] ?? ''}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
                              onPressed: () {
                                // Implement add to cart API if needed
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeFromWishlist(item['product_id']),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}