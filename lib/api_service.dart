import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit_practice/product.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  @GET('/products')
  Future<List<Product>> getProducts();
}

Dio buildDioClient(String base) {
  final dio = Dio()..options = BaseOptions(baseUrl: base);
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
  return dio;
}