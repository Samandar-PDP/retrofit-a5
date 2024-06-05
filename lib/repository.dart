import 'package:retrofit_practice/api_service.dart';
import 'package:retrofit_practice/product.dart';

class Repository {
  final _api = ApiService(buildDioClient("https://fakestoreapi.com"));

  Future<List<Product>> getProducts() => _api.getProducts();
}