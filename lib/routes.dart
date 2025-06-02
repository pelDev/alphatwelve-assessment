import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RouteConstants.initialRoute:
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case RouteConstants.home:
      //   return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case RouteConstants.products:
      //   return MaterialPageRoute(builder: (_) => const FeatureAScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
