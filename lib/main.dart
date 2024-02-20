import 'package:flutter/material.dart';
import 'package:foo_delivery/controllers/cart_controller.dart';
import 'package:foo_delivery/controllers/popular_product_controller.dart';
import 'package:foo_delivery/models/product_models.dart';
import 'package:foo_delivery/pages/account/account_page.dart';
import 'package:foo_delivery/pages/account/account_page2.dart';
import 'package:foo_delivery/pages/auth/sign_in_page.dart';
import 'package:foo_delivery/pages/auth/sign_up_page.dart';
import 'package:foo_delivery/pages/cart/cart_history.dart';
import 'package:foo_delivery/pages/cart/cart_page.dart';
import 'package:foo_delivery/pages/food/popular_food_detail.dart';
import 'package:foo_delivery/pages/food/recommended_food_detail.dart';
import 'package:foo_delivery/pages/splash/splash_page.dart';
import 'package:foo_delivery/routes/route_helper.dart';

import 'controllers/recommended_product_controller.dart';
import 'pages/home/main_food_page.dart';
import 'helper/dependencies.dart' as dep;
import 'package:get/get.dart';
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return  GetBuilder<PopularProductController>(builder: (_)=>
    GetBuilder<RecommendedProductController>(builder: (_)=>
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // home: SplashScreen(),
          // home: AccountPage2(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        )));
  }
}
