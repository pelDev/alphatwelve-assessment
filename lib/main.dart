import 'package:alphatwelve/core/theme/app_theme.dart';
import 'package:alphatwelve/features/cart/cart_injection.dart';
import 'package:alphatwelve/features/product/product_injection.dart';
import 'package:alphatwelve/root/presentation/main_wrapper.dart';
import 'package:alphatwelve/root/presentation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(
    MultiProvider(
      providers: [
        ...ProductInjection.providers,
        ...CartInjection.providers,
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alpha Twelve',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const MainWrapper(),
    );
  }
}