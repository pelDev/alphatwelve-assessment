import 'package:alphatwelve/features/cart/presentation/screens/cart_screen.dart';
import 'package:alphatwelve/features/product/presentation/screens/product_list_screen.dart';
import 'package:flutter/cupertino.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ProductListScreen(),
    const CartScreen(),
  ];

  int get currentIndex => _currentIndex;
  List<Widget> get screens => _screens;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
