import 'package:flutter/material.dart';
import '../utils/wishlist_manager.dart'; // Import the wishlist manager
import '../utils/cart_manager.dart';


class ItemsWidget extends StatefulWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  final List<Product> products = List.generate(
    7,
        (index) => Product(
      'Product Title ${index + 1}',
      'Write description of product ${index + 1}',
      '\$55',
      'images/${index + 1}.jpg',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.75, // Increased from 0.68 to allow more height
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(
        products.length,
            (index) {
          final product = products[index];
          bool isInWishlist = wishlistItems.any((item) => item['name'] == product.name);

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
                      ),
                      onPressed: () {
                        setState(() {
                          if (!isInWishlist) {
                            wishlistItems.add({
                              'name': product.name,
                              'description': product.description,
                              'price': product.price,
                              'image': product.image,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to Wishlist!')),
                            );
                          } else {
                            wishlistItems.removeWhere((item) => item['name'] == product.name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Removed from Wishlist!')),
                            );
                          }
                        });
                      },
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
                      margin: const EdgeInsets.all(8), // Reduced from 10
                      child: Image.asset(
                        product.image,
                        height: 100, // Reduced from 120 to save space
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 6), // Reduced from 8
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16, // Reduced from 18
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
                      fontSize: 9, // Reduced from 10
                      color: Colors.lightGreen,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8), // Reduced from 10
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price,
                        style: const TextStyle(
                          fontSize: 14, // Reduced from 16
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart_checkout,
                          color: Colors.lightGreen,
                          size: 20, // Added size to reduce icon footprint
                        ),
                        onPressed: () {
                          setState(() {
                            if (!cartItems.any((cartItem) => cartItem['name'] == product.name)) {
                              cartItems.add({
                                'name': product.name,
                                'description': product.description,
                                'price': product.price,
                                'image': product.image,
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
      ),
    );
  }
}