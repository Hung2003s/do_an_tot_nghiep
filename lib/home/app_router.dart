import 'package:flutter/material.dart';

// ignore: no_leading_underscores_for_library_prefixes
import 'package:get/get.dart';
import '../const/constant.dart';
import '../ui/detail_item/anatomy_detail_screen.dart';
import '../ui/detail_screen/detail_screen.dart';
import '../ui/homepage/home_page.dart';
import '../ui/intro_screen.dart';
import 'home_tab.dart';
import 'page_material_route.dart';

enum AppRoute {
  detailScreen,
  introScreen,
  homePage,
  anatomyDetailScreen,
  homeTab,
}

extension AppRouteExt on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.detailScreen:
        return '/detail_screen';
      case AppRoute.introScreen:
        return '/intro_screen';
      case AppRoute.homePage:
        return '/home_page';
      case AppRoute.anatomyDetailScreen:
        return '/anatomy_detail_screen';
      case AppRoute.homeTab:
        return '/home_tab';
    }
  }

  static AppRoute? from(String? name) {
    for (final item in AppRoute.values) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  static Route generateRoute(RouteSettings settings) {
    switch (AppRouteExt.from(settings.name)) {
      case AppRoute.detailScreen:
        final dynamic argument = settings.arguments;
        final dynamic arguments = argument[0];
        final dynamic argumentsList = argument[1];
        final FromRoute fromRoute = argument[2];
        final String title = argument[3];
        return PageMaterialRoute(
          settings: settings,
          page:
              () => DetailScreen(
                arguments: arguments,
                argumentsList: argumentsList,
                fromRoute: fromRoute,
                title: title,
              ),
        );

      case AppRoute.introScreen:
        return PageMaterialRoute(
          settings: settings,
          page: () => const IntroScreen(),
        );
      case AppRoute.homePage:
        return PageMaterialRoute(
          settings: settings,
          page: () => const HomePageScreen(),
        );
      case AppRoute.homeTab:
        return PageMaterialRoute(
          settings: settings,
          page: () => const HomeTabs(),
        );
      case AppRoute.anatomyDetailScreen:
        final dynamic argument = settings.arguments;
        final dynamic id = argument[0];
        return PageMaterialRoute(
          settings: settings,
          page: () => AnotomyDetailScreen(id: id),
        );

      default:
        return GetPageRoute(
          settings: settings,
          curve: Curves.ease,
          transition: Transition.rightToLeft,
        );
    }
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> bindingRoute(RouteSettings settings) {
    return AppRouteExt.generateRoute(settings);
  }
}
