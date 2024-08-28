import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_app/auth/auth%20cubit/auth_cubit.dart';
import 'package:the_app/auth/service/auth_service.dart';
import 'package:the_app/config/app_size.dart';
import 'package:the_app/config/routes.dart';
import 'package:the_app/firebase_options.dart';
import 'package:the_app/home/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.appHeight = MediaQuery.of(context).size.height;
    AppSize.appWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authService: AuthService()),
        ),
        BlocProvider(
          create: (context) => TaskCubit(),
        ),
      ],
      child: const MaterialApp(
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
