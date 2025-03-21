import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/app_router.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: AppRouteExt.navigatorKey,
      initialRoute: AppRoute.introScreen.name,
      onGenerateRoute: AppRouteExt.bindingRoute,
      initialBinding: AppBinding(),
      navigatorObservers: <NavigatorObserver>[routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
        useMaterial3: true,
      ),
      // home: const IntroScreen(),
    );
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {}
}

