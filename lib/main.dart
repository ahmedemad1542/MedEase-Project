import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/utils/storage_helper.dart';

import 'package:medease1/generated/l10n.dart';
import 'package:medease1/core/routing/router_generation_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  sl<StorageHelper>().deleteData(key: "accesstoken");
  sl<StorageHelper>().deleteData(key: "role");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          locale: const Locale('en'),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'MedEase',
          // You can use the library anywhere in the app even in theme
          routerConfig: RouterGenerationConfig.goRouter,
        );
      },
    );
  }
}
