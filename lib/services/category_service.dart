import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoryService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/categories';

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}