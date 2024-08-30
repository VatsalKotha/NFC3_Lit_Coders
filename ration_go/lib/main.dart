import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ration_go/cart/cart.dart';
import 'package:ration_go/features/auth/bloc/auth_bloc.dart';
import 'package:ration_go/features/auth/ui/login_screen.dart';
import 'package:ration_go/features/auth/ui/splash_screen.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as gt;
import 'package:ration_go/features/home/ui/home_screen.dart';
import 'package:ration_go/features/product/bloc/product_bloc.dart';
import 'package:ration_go/features/product/ui/product_screen.dart';
import 'package:ration_go/myorders/myorders.dart';
import 'package:ration_go/myorders/orderdetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc(Dio()),
        ),
        BlocProvider(create: (BuildContext context) => ProductBloc(Dio())),
      ],
      child: GetMaterialApp(
          title: 'Ration Go!',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Poppins',
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          transitionDuration: const Duration(milliseconds: 1000),
          getPages: [
            GetPage(
              name: '/',
              page: () => const SplashScreen(),
              transition: gt.Transition.noTransition,
            ),
            GetPage(
              name: '/login',
              page: () => const LoginScreen(),
              transition: gt.Transition.noTransition,
            ),
            GetPage(
              name: '/home',
              page: () => const HomeScreen(),
              transition: gt.Transition.noTransition,
            ),
            GetPage(
              name: '/product',
              page: () => ProductScreen(),
              transition: gt.Transition.noTransition,
            ),
            GetPage(
              name: '/cart',
              page: () => Cart(),
              transition: gt.Transition.noTransition,
            ),
            GetPage(
              name: '/myorders',
              page: () => Myorders(),
              transition: gt.Transition.noTransition,
            ),
            GetPage(
              name: '/orderdetails',
              page: () => Orderdetails(),
              transition: gt.Transition.noTransition,
            ),
          ]),
    );
  }
}
