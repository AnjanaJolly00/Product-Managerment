import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinetest/core/data/repository/auth_repo.dart';
import 'package:machinetest/core/data/repository/product_repo.dart';
import 'package:machinetest/features/auth/login_screen.dart';
import 'package:machinetest/features/pin_login/pin_screen.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'package:machinetest/shared/utils/sharedprefs_key.dart';
import 'core/data/preferences/shared_preferences.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/product_management/bloc/product_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  await SharedPrefs.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()),
    ),
    BlocProvider(
      create: (context) => ProductBloc(productRepository: ProductRepository()),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
        useMaterial3: true,
      ),
      home: SharedPrefs.getbool(PrefConstants.isLoggedIn)
          ? const PinScreen()
          : LoginScreen(),
    );
  }
}
