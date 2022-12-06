import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_login/constants/routes.dart';
import 'package:responsive_login/ui/auth/login_screen.dart';
import 'package:responsive_login/ui/auth/sign_up_screen.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const LoginScreen(),
      // middlewares: [
      //   AuthGuard(),
      // ],
      // bindings: [
      //   DashboardBinding(),
      // ],
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const Scaffold(
        body: Center(
          child: Text("Welcome to the dashboard"),
        ),
      ),
    ),
  ];
}
