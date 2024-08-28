import 'package:flutter/material.dart';
import 'package:the_app/auth/screens/sign_up_screen.dart';

class Routes {
  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SignUpScreen.route:
        return MaterialPageRoute(
            builder: (_) => const SignUpScreen(), settings: settings);
    }
    return null;
  }
}
