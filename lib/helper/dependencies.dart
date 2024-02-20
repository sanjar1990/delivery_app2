import 'package:foo_delivery/controllers/auth_controller.dart';
import 'package:foo_delivery/controllers/cart_controller.dart';
import 'package:foo_delivery/controllers/popular_product_controller.dart';
import 'package:foo_delivery/controllers/user_controller.dart';
import 'package:foo_delivery/data/api/api_client.dart';
import 'package:foo_delivery/data/repository/auth_repo.dart';
import 'package:foo_delivery/data/repository/cart_repo.dart';
import 'package:foo_delivery/data/repository/popular_product_repo.dart';
import 'package:foo_delivery/data/repository/user_repo.dart';
import 'package:foo_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void>init()async{
  final sharedPreferences= await SharedPreferences.getInstance();
  Get.lazyPut( ()=>sharedPreferences);
  //api client
  Get.lazyPut(()=>ApiClient(
     sharedPreferences:Get.find()
  ));
  //repository
  Get.lazyPut(()=>PopularProductRepo( apiClient: Get.find()));
  Get.lazyPut(()=>RecommendedProductRepo( apiClient: Get.find()));
  Get.lazyPut(()=>CartRepo(sharedPreferences: sharedPreferences));
  Get.lazyPut(()=>AuthRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
  Get.lazyPut(()=>UserRepo( apiClient: Get.find()));

  // controller
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(()=>CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));

}