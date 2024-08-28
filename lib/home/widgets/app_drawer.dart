import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_app/auth/screens/login_screen.dart';
import 'package:the_app/config/app_size.dart';
import 'package:the_app/config/theme_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) => Container(
        color: state == ThemeMode.light ? Colors.white : Colors.grey.shade900,
        height: double.infinity,
        width: AppSize.appWidth / 3,
        child: Center(child: GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            await Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route, (Route <dynamic> route) => false);
          },
          child: Text("Logout", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
                  color: state == ThemeMode.light ? Colors.black : Colors.white,
                ),),
        ))),
    );
  }
}