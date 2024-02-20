import 'package:foo_delivery/pages/auth/sign_in_page.dart';
import 'package:foo_delivery/pages/cart/cart_page.dart';
import 'package:foo_delivery/pages/food/popular_food_detail.dart';
import 'package:foo_delivery/pages/food/recommended_food_detail.dart';
import 'package:foo_delivery/pages/home/home_page.dart';
import 'package:foo_delivery/pages/home/main_food_page.dart';
import 'package:foo_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteHelper {
  static const String initial='/';
  static const String splashPage='/splash-page';
  static const String popularFood='/popular-food';
  static const String recommendedFood='/recommended-food';
  static const String cartPage='/cart-page';
  static const String signIn='/sign-in';

  static String getInitial()=>'$initial';
  static String getSignInPage()=>'$signIn';
  static String getSplashPage()=>'$splashPage';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage(  int pageId,String page)=>'$cartPage?pageId=$pageId&page=$page';
  static List<GetPage>routes=[
    GetPage(name: signIn, page: ()=>SignInPage(), transition: Transition.fadeIn),
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: ()=> HomePage()),
    GetPage(name: popularFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
    },
    transition: Transition.fadeIn
    ),
  GetPage(name: recommendedFood, page: (){
    var pageId=Get.parameters['pageId'];
    var page=Get.parameters['page'];
  return RecommendedFoodDetail(pageId:int.parse(pageId!),page: page!);
  },
  transition: Transition.fadeIn
  ),
    GetPage(name: cartPage, page: (){
      var page=Get.parameters['page'];
      var pageId=Get.parameters['pageId'];
      return CartPage(page:page!, pageId: int.parse(pageId!),);
    },
      transition: Transition.fadeIn
    ),

  ];
}