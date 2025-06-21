import 'package:flutter/material.dart';
import '../widgets/HomeAppBar.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/wishlist_service.dart';
import '../utils/cart_manager.dart';

class CategoryProductsPage extends StatefulWidget {
  final int categoryId;

  const CategoryProductsPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  late Future<List<Product>> _futureProducts;
  List<Map<String, dynamic>> _wishlist = [];

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService.fetchProductsByCategory(widget.categoryId);
    _loadWishlist();
  }

  void _loadWishlist() async {
    final wishlist = await WishlistService.fetchWishlist();
    setState(() {
      _wishlist = wishlist;
    });
  }

  bool _isInWishlist(int productId) {
    return _wishlist.any((item) => item['product_id'] == productId);
  }

  void _toggleWishlist(Product product) async {
    if (_isInWishlist(product.id)) {
      await WishlistService.removeFromWishlist(product.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removed from Wishlist!')),
      );
    } else {
      await WishlistService.addToWishlist(product.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to Wishlist!')),
      );
    }
    _loadWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: HomeAppBar(),
      ),
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
                Text(
                  'Category ${widget.categoryId}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  final categoryProducts = snapshot.data!;

                  return GridView.builder(
                    itemCount: categoryProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = categoryProducts[index];
                      final isInWishlist = _isInWishlist(product.id);

                      return Container(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "-50%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isInWishlist ? Icons.favorite : Icons.favorite_border,
                                    color: isInWishlist ? Colors.red : Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () => _toggleWishlist(product),
                                ),
                              ],
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    'itemPage',
                                    arguments: product,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: product.images.isNotEmpty
                                      ? Image.network(
                                    product.images[0],
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.image, size: 80),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 6),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.description,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.lightGreen,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightGreen,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.shopping_cart_checkout,
                                      color: Colors.lightGreen,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (!cartItems.any((item) => item['id'] == product.id)) {
                                          cartItems.add({
                                            'id': product.id,
                                            'name': product.name,
                                            'description': product.description,
                                            'price': product.price,
                                            'image': product.images.isNotEmpty ? product.images[0] : '',
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Added to Cart!')),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Item already in Cart!')),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
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
