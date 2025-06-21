import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/users'; // Use your backend IP if not using emulator

  // Get profile of customer
  static Future<User?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/profile');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // Register
  static Future<User?> registerUser(String email, String password, String name, String phone) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'name': name, 'phone': phone}),
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // Login
  static Future<User?> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // Fetch cart items
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return [];

    // Note: If your cart API is at /api/cart, change the URL accordingly
    final url = Uri.parse('http://10.0.2.2:3000/api/cart');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }
    return [];
  }

  // Remove a cart item
  static Future<bool> removeCartItem(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return false;

    final url = Uri.parse('http://10.0.2.2:3000/api/cart/remove');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'itemId': itemId}),
    );
    return response.statusCode == 200;
  }
  // Checkout cart
  static Future<bool> checkoutCart() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return false;

    final url = Uri.parse('http://10.0.2.2:3000/api/cart/checkout');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response.statusCode == 200;
  }

  static Future<String?> getSellerApplicationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    final url = Uri.parse('http://10.0.2.2:3000/api/users/seller-application-status');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status']; // 'pending', 'approved', or null
    }
    return null;
  }


  static Future<List<Map<String, dynamic>>> getPendingFarmers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return [];
    final url = Uri.parse('http://10.0.2.2:3000/api/users/pending-farmers');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }
    return [];
  }

  static Future<bool> approveFarmer(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return false;
    final url = Uri.parse('http://10.0.2.2:3000/api/users/approve-farmer/$userId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response.statusCode == 200;
  }

  static Future<List<Map<String, dynamic>>> getPendingFarmerApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return [];
    final url = Uri.parse('http://10.0.2.2:3000/api/users/pending-farmer-applications');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }
    return [];
  }  static Future<bool> rejectFarmer(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return false;
    final url = Uri.parse('http://10.0.2.2:3000/api/users/reject-farmer/$userId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response.statusCode == 200;
  }
  // Apply to become a farmer (token is loaded automatically)
  static Future<bool> applyFarmer({
    required String shopName,
    required String province,
    required String district,
    required String commune,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/apply-farmer');
    final response = await http.post(
        url,
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
        'shopName': shopName,
        'province': province,
          'district': district,
          'commune': commune,
        }),
    );
    return response.statusCode == 200;
  }
}