import 'package:alphatwelve/features/product/domain/entities/category_entity.dart';
import 'package:alphatwelve/features/product/domain/entities/product_entity.dart';
import 'package:alphatwelve/features/product/domain/usecases/get_product_by_id.dart';
import 'package:alphatwelve/features/product/domain/usecases/get_products.dart';
import 'package:flutter/foundation.dart';

final _sampleCategory = CategoryEntity(
  id: '1',
  name: 'Technology',
  description: 'Smartphones, Laptops & Assecories',
);

class ProductProvider with ChangeNotifier {
  final GetProductsUseCase getProducts;
  final GetProductByIdUseCase getProductById;

  List<ProductEntity> _products = [];
  bool _isLoading = false;
  String? _error;
  CategoryEntity _category = _sampleCategory;

  ProductProvider({
    required this.getProducts,
    required this.getProductById,
  });

  List<ProductEntity> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  CategoryEntity get selectedCategory => _category;

  Future<void> fetchProducts({bool refresh = false}) async {
    if (refresh) _products = [];
    _isLoading = true;
    notifyListeners();

    try {
      _products = await getProducts();
      _error = null;
    } catch (e) {
      _error = e
          .toString(); // Better error handling for when using remote datasource
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ProductEntity> getProduct(String id) async {
    return await getProductById(id);
  }
}
