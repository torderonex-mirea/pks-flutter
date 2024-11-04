import 'package:dio/dio.dart';

import '../models/product.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8080/products');
      print(response.data);
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/products/create',
        data: product.toJson(),
      );
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('http://10.0.2.2:8080/products/delete/$id');
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

}