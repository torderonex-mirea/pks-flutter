import 'package:dio/dio.dart';
import '../models/product.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:6969';

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('$_baseUrl/products');
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

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      throw Exception('Error fetching product by ID: $e');
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/products',
        data: product.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  Future<void> updateProductById(int id, Product product) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/products/$id',
        data: product.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('$_baseUrl/products/$id');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
