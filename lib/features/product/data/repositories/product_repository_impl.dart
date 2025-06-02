import 'package:alphatwelve/core/network/network_info.dart';
import 'package:alphatwelve/features/product/data/datasources/product_datasource.dart';
import 'package:alphatwelve/features/product/domain/entities/product_entity.dart';
import 'package:alphatwelve/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<ProductEntity>> getProducts() async {
    // Only interested in local for now
    if (await networkInfo.canMakeApiRequests && false) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        // Cache fetched products to local
        return remoteProducts;
      } catch (e) {
        return await localDataSource.getProducts();
      }
    } else {
      return await localDataSource.getProducts();
    }
  }

  @override
  Future<ProductEntity> getProductById(String id) async {
    return await localDataSource.getProductById(id);
  }
}
