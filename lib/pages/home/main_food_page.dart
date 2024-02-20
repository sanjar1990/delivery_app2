import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/pages/home/food_page_body.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:foo_delivery/widgets/big_text.dart';
import 'package:foo_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/colors.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() {
    return _MainFoodPageState();
  }
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    Future<void> _loadResources() async{
      await Get.find<PopularProductController>().getPopularProductList();
      await Get.find<RecommendedProductController>().getRecommendedProductList();
    }
    return Scaffold(
      body: RefreshIndicator(child: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45,
                  bottom: Dimensions.height15),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      BigText(
                        text: 'Uzbekistan',
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(text: 'Tashkent'),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 24,
                          )
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      height: Dimensions.height45,
                      width: Dimensions.width45,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                      child:  Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.icon24,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //body
          Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),onRefresh: _loadResources,),
    );
  }
}
