import 'package:alphatwelve/core/network/network_info.dart';
import 'package:alphatwelve/features/product/data/datasources/product_datasource.dart';
import 'package:alphatwelve/features/product/data/datasources/product_local_datasource.dart';
import 'package:alphatwelve/features/product/data/datasources/product_remote_datasource.dart';
import 'package:alphatwelve/features/product/data/repositories/product_repository_impl.dart';
import 'package:alphatwelve/features/product/domain/repositories/product_repository.dart';
import 'package:alphatwelve/features/product/domain/usecases/get_product_by_id.dart';
import 'package:alphatwelve/features/product/domain/usecases/get_products.dart';
import 'package:alphatwelve/features/product/presentation/providers/product_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProductInjection {
  static List<SingleChildWidget> providers = [
    Provider<ProductRemoteDataSource>(
      create: (_) => ProductRemoteDataSourceImpl(
        Dio(),
      ), // The Dio passed would be changed in real-life
    ),
    Provider<ProductLocalDataSource>(
      create: (_) => ProductLocalDataSourceImpl(),
    ),
    Provider<NetworkInfo>(
      create: (_) => NetworkInfoImpl(Connectivity()),
    ),
    Provider<ProductRepository>(
      create: (context) => ProductRepositoryImpl(
        remoteDataSource: context.read<ProductRemoteDataSource>(),
        localDataSource: context.read<ProductLocalDataSource>(),
        networkInfo: context.read<NetworkInfo>(),
      ),
    ),
    Provider<GetProductsUseCase>(
      create: (context) =>
          GetProductsUseCase(context.read<ProductRepository>()),
    ),
    Provider<GetProductByIdUseCase>(
      create: (context) =>
          GetProductByIdUseCase(context.read<ProductRepository>()),
    ),
    ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(
        getProducts: context.read<GetProductsUseCase>(),
        getProductById: context.read<GetProductByIdUseCase>(),
      ),
    ),
  ];
}
