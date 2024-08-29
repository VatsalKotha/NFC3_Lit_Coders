import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:ration_go/features/auth/ui/login_screen.dart';
import 'package:ration_go/features/auth/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        transitionDuration: const Duration(milliseconds: 1000),
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashScreen(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/login',
            page: () => const LoginScreen(),
            transition: Transition.noTransition,
          ),
        ]);
  }
}
