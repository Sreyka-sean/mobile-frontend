class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> images; // List of image URLs

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Parse images array from backend
    List<String> imageUrls = [];
    if (json['images'] != null && json['images'] is List) {
      imageUrls = (json['images'] as List)
          .map((img) => img['img_url'] as String)
          .toList();
    }

    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] is String
          ? double.parse(json['price'])
          : (json['price'] ?? 0).toDouble(),
      images: imageUrls,
    );
  }
}