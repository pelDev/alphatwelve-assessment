import 'package:alphatwelve/features/product/data/datasources/product_datasource.dart';
import 'package:alphatwelve/features/product/data/models/product_model.dart';
import 'package:dio/dio.dart';

// To be updated for actual remote sources. For now, this is a placeholder
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get('/products');
    return (response.data as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<ProductModel> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }
}
