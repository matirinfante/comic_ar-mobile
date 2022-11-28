import 'package:animations/animations.dart';
import 'package:bart/bart.dart';
import 'package:comic_ar/screens/comicteca_page.dart';
import 'package:comic_ar/screens/home.dart';
import 'package:comic_ar/theme/colors.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future appPushNamed(String route, {Object? arguments}) =>
    navigatorKey.currentState!.pushNamed(route, arguments: arguments);

List<BartMenuRoute> subRoutes() {
  return [
    BartMenuRoute.bottomBar(
      label: "Inicio",
      icon: Icons.home_rounded,
      path: '/home',
      pageBuilder: (parentContext, tabContext, settings) => HomeScreen(
        key: const PageStorageKey<String>("home"),
        parentContext: parentContext,
      ),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.bottomBar(
      label: "Comicteca",
      icon: Icons.menu_book_rounded,
      path: '/library',
      pageBuilder: (parentContext, tabContext, settings) => const ComictecaPage(
        key: PageStorageKey<String>("library"),
      ),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.bottomBar(
      label: "Perfil",
      icon: Icons.person_rounded,
      path: '/profile',
      pageBuilder: (parentContext, tabContext, settings) => Container(
          key: const PageStorageKey<String>("profile"),
          child: const Center(child: Text('Profile page'))),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    )
  ];
}

Widget bottomBarTransition(
  BuildContext c,
  Animation<double> a1,
  Animation<double> a2,
  Widget child,
) =>
    FadeThroughTransition(
      animation: a1,
      secondaryAnimation: a2,
      fillColor: kBackgroundColor,
      child: child,
    );

const bottomBarTransitionDuration = Duration(milliseconds: 700);
