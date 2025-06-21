import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    print('fetchProducts status: ${response.statusCode}');
    print('fetchProducts body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // If your backend returns a list directly:
      if (data is List) {
        return data.map((item) => Product.fromJson(item)).toList();
      }
      // If your backend returns an object with a 'products' key:
      if (data is Map && data['products'] is List) {
        return (data['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final response = await http.get(
        Uri.parse('$baseUrl?category_id=$categoryId'));
    print('fetchProductsByCategory status: ${response.statusCode}');
    print('fetchProductsByCategory body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return data.map((item) => Product.fromJson(item)).toList();
      }
      if (data is Map && data['products'] is List) {
        return (data['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    print('fetchProductById status: ${response.statusCode}');
    print('fetchProductById body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // If your backend returns a single product object:
      if (data is Map) {
        return Product.fromJson(Map<String, dynamic>.from(data));
      }
      // If your backend returns a list with one product:
      if (data is List && data.isNotEmpty) {
        return Product.fromJson(data[0]);
      }
      throw Exception('Product not found');
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<List<Product>> fetchSuggestedProducts(int excludeId) async {
    final response = await http.get(
        Uri.parse('$baseUrl?suggested_for=$excludeId'));
    print('fetchSuggestedProducts status: ${response.statusCode}');
    print('fetchSuggestedProducts body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return data.map((item) => Product.fromJson(item)).toList();
      }
      if (data is Map && data['products'] is List) {
        return (data['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to load suggested products');
    }
  }

  static Future<List<Product>> fetchBestSellers() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/sales/best-products'));
    print('fetchBestSellers status: ${response.statusCode}');
    print('fetchBestSellers body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => Product.fromJson(item)).toList();
      }
      if (data is Map && data['products'] is List) {
        return (data['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to load best sellers');
    }
  }

  static Future<List<Product>> fetchRegularProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/regular'));
    print('fetchRegularProducts status: ${response.statusCode}');
    print('fetchRegularProducts body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return data.map<Product>((item) => Product.fromJson(item)).toList();
      }
      if (data is Map && data['products'] is List) {
        return (data['products'] as List)
            .map<Product>((item) => Product.fromJson(item))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to load regular products');
    }
  }
}