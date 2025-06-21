import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/ItemAppBar.dart';
import '../widgets/ItemBottomNavBar.dart';

class ItemPage extends StatefulWidget {
  final int productId; // Pass productId instead of Product

  const ItemPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late Future<Product> _futureProduct;
  late Future<List<Product>> _futureSuggested;

  @override
  void initState() {
    super.initState();
    _futureProduct = ProductService.fetchProductById(widget.productId);
    _futureSuggested = ProductService.fetchSuggestedProducts(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcbcbcb),
      body: FutureBuilder<Product>(
        future: _futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found.'));
          }
          final product = snapshot.data!;
          return ListView(
            children: [
              ItemAppBar(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: product.images.isNotEmpty
                    ? Image.network(product.images[0], height: 300)
                    : const Icon(Icons.image, size: 120),
              ),
              // ... (rest of your UI, using product.name, product.description, etc.)
              // Suggested Products Section
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Suggested Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See All"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: FutureBuilder<List<Product>>(
                  future: _futureSuggested,
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snap.hasError) {
                      return Center(child: Text('Error: ${snap.error}'));
                    } else if (!snap.hasData || snap.data!.isEmpty) {
                      return const Center(child: Text('No suggestions.'));
                    }
                    final suggestedProducts = snap.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: suggestedProducts.length > 5 ? 5 : suggestedProducts.length,
                      itemBuilder: (context, index) {
                        final suggestedProduct = suggestedProducts[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemPage(productId: suggestedProduct.id),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  suggestedProduct.images.isNotEmpty
                                      ? Image.network(
                                    suggestedProduct.images[0],
                                    height: 120,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.image, size: 80),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      suggestedProduct.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      '\$${suggestedProduct.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // ... (rest of your UI)
            ],
          );
        },
      ),
      bottomNavigationBar: ItemBottomNavBar(),
    );
  }
}