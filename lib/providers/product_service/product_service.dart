import 'dart:convert';
import 'dart:developer';

import 'package:shopping_app_jhonny_mustafa/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getProduct() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        log("service_method::${response.request} -> params_response::${jsonData.toString()}");

        return jsonData.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  //[GET] https://api.escuelajs.co/api/v1/products/4
  Future<Product> getDetailProduct(int id) async {
    try {
      final response = await http
          .get(Uri.parse('https://api.escuelajs.co/api/v1/products/$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log("service_method::${response.request} -> params_response::${jsonData.toString()}");

        //return jsonData.map((e) => Product.fromJson(e).);
        return Product.fromJson(jsonData);
      } else {
        throw Exception('Failed to load single data');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Future<int> fetchProductId() async {
  //   final response =
  //       await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products/'));
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final productId = data['product_id']; // Ganti dengan key yang sesuai
  //     return productId;
  //   } else {
  //     throw Exception('Failed to load product data');
  //   }
  // }
}
