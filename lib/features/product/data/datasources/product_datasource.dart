import 'package:alphatwelve/features/product/data/models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
}

abstract class ProductRemoteDataSource extends ProductDataSource {}

abstract class ProductLocalDataSource extends ProductDataSource {}
