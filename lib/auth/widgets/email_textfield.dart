import 'package:flutter/material.dart';

class EmailTextfield extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextfield({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(hintText: "Enter email"),
      ),
    );
  }
}
