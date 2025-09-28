import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to load products: ${response.statusCode}');
    }
  }
}
