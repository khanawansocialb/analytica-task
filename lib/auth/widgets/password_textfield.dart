import 'package:flutter/material.dart';

class PasswordTextfield extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextfield({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(hintText: "Enter password"),
      ),
    );
  }
}
