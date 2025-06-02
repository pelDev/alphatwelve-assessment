import 'package:alphatwelve/features/product/data/datasources/product_datasource.dart';
import 'package:alphatwelve/features/product/data/models/product_model.dart';

const _sharedDesc = 'About this item\n'
    '• This pre-owned product is not Apple certified, but has been professionally inspected, tested and cleaned by Amazon-qualified suppliers.\n'
    '• There will be no visible cosmetic imperfections when held at an arm\'s length.\n'
    '• This product will have a battery which exceeds 80% capacity relative to new.\n'
    '• Accessories will not be original, but will be compatible and fully functional. Product may come in generic Box.\n'
    '• This product is eligible for a replacement or refund within 90 days of receipt if you are not satisfied.';

var products = [
  ProductModel(
    id: '1',
    name: 'Apple iPhone 16 128GB|Teal',
    description: _sharedDesc,
    price: 700,
    imageUrl: 'assets/images/iphone_product.png',
    currency: 'USD',
  ),
  ProductModel(
    id: '2',
    name: 'M4 Macbook Air 13 256GB|Sky blue',
    description: _sharedDesc,
    price: 1000,
    imageUrl: 'assets/images/mac_product.png',
    currency: 'USD',
  ),
  ProductModel(
    id: '3',
    name: 'Google Pixel 9A 128GB|Iris',
    description: _sharedDesc,
    currency: 'USD',
    price: 499,
    imageUrl: 'assets/images/pixel_product.png',
  ),
  ProductModel(
    id: '4',
    name: 'Apple Airpods 4 Active Noise Cancellation|Teal',
    description: _sharedDesc,
    currency: 'USD',
    price: 129,
    imageUrl: 'assets/images/airpod_product.png',
  ),
];

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));

    return products;
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    return products.firstWhere((p) => p.id == id);
  }
}
