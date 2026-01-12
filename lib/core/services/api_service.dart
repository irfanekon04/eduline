import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eduline/core/models/product_model.dart';

class ApiService {
  final String baseUrlStr = "https://api.restful-api.dev";

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrlStr/objects"));

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw "Failed to load products: ${response.statusCode}";
      }
    } catch (e) {
      throw "An error occurred: $e";
    }
  }
}
