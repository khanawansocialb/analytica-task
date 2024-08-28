import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_app/auth/screens/login_screen.dart';
import 'package:the_app/auth/screens/sign_up_screen.dart';

class TextMsg extends StatelessWidget {
  final bool isLoginScreen;
  final String msg;
  const TextMsg({super.key, required this.isLoginScreen, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(msg),
        TextButton(
            onPressed: () {
              if (isLoginScreen) {
                Navigator.pushReplacementNamed(context, SignUpScreen.route);
              } else {
                Navigator.pushReplacementNamed(context, LoginScreen.route);
              }
            },
            child: const Text("Tap"))
      ],
    );
  }
}
