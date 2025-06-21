import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WishlistService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/wishlist';

  // Retrieve the token from SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Make sure you save the token as 'token' after login
  }

  static Future<List<Map<String, dynamic>>> fetchWishlist() async {
    final token = await getToken();
    if (token == null) throw Exception('No user token found');
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('fetchWishlist status: ${response.statusCode}');
    print('fetchWishlist body: ${response.body}');
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load wishlist');
    }
  }

  static Future<void> addToWishlist(int productId) async {
    final token = await getToken();
    if (token == null) throw Exception('No user token found');
    await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'product_id': productId}),
    );
  }

  static Future<void> removeFromWishlist(int productId) async {
    final token = await getToken();
    if (token == null) throw Exception('No user token found');
    await http.post(
      Uri.parse('$baseUrl/remove'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'product_id': productId}),
    );
  }
}