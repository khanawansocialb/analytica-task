import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_app/auth/auth%20cubit/auth_cubit.dart';
import 'package:the_app/auth/widgets/email_textfield.dart';
import 'package:the_app/auth/widgets/password_textfield.dart';
import 'package:the_app/auth/widgets/text_msg.dart';
import 'package:the_app/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "/login";
  const LoginScreen({super.key});

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
                const Text("Login account", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                        context.read<AuthCubit>().loginWithEmailAndPassword(
                            email: emailController.text,
                            password: pswdContoller.text);
                      }
                    },
                    child: const Text("Login")),
                 const SizedBox(height: 20),
                 const TextMsg(isLoginScreen: true, msg: "No account yet"),   
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
