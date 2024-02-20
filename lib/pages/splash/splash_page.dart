import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/routes/route_helper.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState() {
    _loadResources();
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3)
    )..forward();
    animation = CurvedAnimation(parent: controller,
        curve: Curves.linear);
  Timer(Duration(seconds: 3),()=>Get.offNamed(RouteHelper.getInitial()));
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            ScaleTransition(

                scale: animation,

                child: Image.asset('assets/images/logo part 1.png', width: Dimensions.splashImg,)),
            Image.asset('assets/images/logo part 2.png', width:  Dimensions.splashImg,),
          ],
        ),
      ),
    );
  }
}
