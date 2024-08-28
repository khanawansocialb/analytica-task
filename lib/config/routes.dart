import 'package:flutter/material.dart';
import 'package:the_app/auth/screens/login_screen.dart';
import 'package:the_app/auth/screens/sign_up_screen.dart';
import 'package:the_app/home/home_screen.dart';

class Routes {
  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SignUpScreen.route:
        return MaterialPageRoute(
            builder: (_) => const SignUpScreen(), settings: settings);
      case LoginScreen.route:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(), settings: settings);
      case HomeScreen.route:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(), settings: settings);
    }
    return null;
  }
}
