import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_app/auth/auth%20cubit/auth_cubit.dart';
import 'package:the_app/auth/widgets/email_textfield.dart';
import 'package:the_app/auth/widgets/password_textfield.dart';
import 'package:the_app/home/home_screen.dart';

import '../widgets/text_msg.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = "/";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pswdContoller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route, (Route <dynamic> route) => false);
            }
            if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Something went wrong")));
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Register account", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                EmailTextfield(emailController: emailController),
                const SizedBox(
                  height: 50,
                ),
                PasswordTextfield(passwordController: pswdContoller),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          pswdContoller.text.isNotEmpty) {
                        context.read<AuthCubit>().signUpWithEmailAndPassword(
                            email: emailController.text,
                            password: pswdContoller.text);
                      }
                    },
                    child: const Text("Sign up")),
                    const SizedBox(height: 20),
                 const TextMsg(isLoginScreen: false, msg: "Have an account"), 
                const SizedBox(height: 20),
                if (state is AuthLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
