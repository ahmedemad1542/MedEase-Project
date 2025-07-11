import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/features/Ai%20Chatbot/cubit/chatbot_cubit.dart';

import 'package:medease1/generated/l10n.dart';
import 'package:medease1/core/routing/router_generation_config.dart';

import 'core/utils/role_service.dart';
import 'features/disease/disease_cubit.dart';
import 'features/disease/disease_repo.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/profile/repo/profile_repo.dart';
import 'features/treatment/treatment_cubit.dart';
import 'features/treatment/treatment_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  // Initialize the RoleService to load the user role from storage
  await sl<RoleService>().init();

  // sl<StorageHelper>().deleteData(key: StorageKeys.accessToken);
  // sl<StorageHelper>().deleteData(key: StorageKeys.role);
  // sl<StorageHelper>().saveData(
  //   key: StorageKeys.accessToken,
  //   value:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODBhYWQxYzFjZmI1MmRjZmEzMGE5MjUiLCJuYW1lIjoiS2ggTWgiLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE3NTEzNzk0MTcsImV4cCI6MTc1MTM4MDMxN30.vUIKXm-RSJ47ldjK5B4KHBAulBhbuyNgXl9ZGYUck4g',
  // );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DiseaseCubit(sl<DiseaseRepo>())),
        BlocProvider(create: (context) => TreatmentCubit(sl<TreatmentRepo>())),
        BlocProvider(create: (_) => ChatCubit()),
        BlocProvider(
          create: (context) => ProfileCubit(sl<ProfileRepo>()),
          child: const MyApp(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
