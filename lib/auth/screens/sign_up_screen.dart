import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = "/";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Enter email"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text ("Sign up"))
          ],
        ),
      ),
    );
  }
}
