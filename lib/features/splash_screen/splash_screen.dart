import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/core/storage/storage_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () async {
      String? token = await StorageHelper().getData(
        key: StorageKeys.accessToken,
      );
      String? role = await StorageHelper().getData(key: StorageKeys.role);

      if (token == null) {
        context.goNamed(AppRoutes.loginScreen);
      } else {
        if (role == 'Patient') {
          context.goNamed(AppRoutes.patientScreen);
        } else if (role == 'user') {
          context.goNamed(AppRoutes.homeScreen);
        } else {
          context.goNamed(AppRoutes.loginScreen);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.jpg', // ضع شعار التطبيق في مجلد assets
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
