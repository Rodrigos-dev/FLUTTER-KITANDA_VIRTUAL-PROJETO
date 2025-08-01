

import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/view/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/base/binding/navigation_binding.dart';
import 'package:greengrocer/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrocer/src/pages/home/binding/home_binding.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';

abstract class AppPages{

  static final pages = <GetPage>[

    GetPage(
      page: () => ProductScreen(),
      name: PagesRoutes.productRoute,
    ),

    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),

    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signinRoute,
    ),

    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.signupRoute,
    ),

    GetPage(
      page: () => BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
      ],
    ),

  ];
}


abstract class PagesRoutes{
  static const String productRoute = '/product';
  static const String splashRoute = '/splash';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String baseRoute = '/';
}
