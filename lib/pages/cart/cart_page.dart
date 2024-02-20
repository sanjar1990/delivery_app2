import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/base/no_data_page.dart';
import 'package:foo_delivery/controllers/auth_controller.dart';
import 'package:foo_delivery/controllers/cart_controller.dart';
import 'package:foo_delivery/controllers/popular_product_controller.dart';
import 'package:foo_delivery/controllers/recommended_product_controller.dart';
import 'package:foo_delivery/pages/cart/cart_history.dart';
import 'package:foo_delivery/pages/home/main_food_page.dart';
import 'package:foo_delivery/routes/route_helper.dart';
import 'package:foo_delivery/utils/app_constants.dart';
import 'package:foo_delivery/utils/colors.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:foo_delivery/widgets/app_icon.dart';
import 'package:foo_delivery/widgets/big_text.dart';
import 'package:foo_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final String page;
  final int pageId;
  const CartPage({super.key, required this.page, required this.pageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
              right: Dimensions.width20,
              left: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                  onTap: (){
                   if(page=='popularProduct'){
                     Get.toNamed(RouteHelper.getPopularFood(pageId, page));
                   }else if(page=='recommendedProduct'){
                     Get.toNamed(RouteHelper.getRecommendedFood(pageId, page));
                   }else if(page=='cartHistory'){
                     Get.to(CartHistory());
                   }

                  },
                  child: AppIcon(icon: Icons.arrow_back_ios_new,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.icon24,),
                ),
                SizedBox(
                  width: Dimensions.width20*5,
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.icon24,),
                ),
                AppIcon(icon: Icons.shopping_cart,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.icon24,),

              ],)),
         GetBuilder<CartController>(builder: (_cartController){
           return _cartController.getItems.length>0? Positioned(
               top: Dimensions.height20*5,
               left: Dimensions.width20,
               right: Dimensions.width20,
               bottom: 0,
               child: Container(
                 margin: EdgeInsets.only(top: Dimensions.height15),
                 child: MediaQuery.removePadding(
                   context: context,
                   removeTop:true ,
                   child:GetBuilder<CartController>(builder: (cartController){
                     var _cartList=cartController.getItems;
                     return  ListView.builder(
                         itemCount: _cartList.length,
                         itemBuilder: (ctx, index){
                           return Container(
                             height: Dimensions.height20*5,
                             width: double.maxFinite,

                             child: Row(
                               children: [
                                 GestureDetector(
                                   onTap: (){
                                     var popularIndex=Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                                     if(popularIndex>=0){
                                       Get.toNamed(RouteHelper.getPopularFood(popularIndex, 'cartPage'));

                                     }else{
                                       var recommendedIndex=Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product!);
                                       if(recommendedIndex<0){
                                         Get.snackbar('History Product', 'Review is not available for history products',
                                             backgroundColor: AppColors.mainColor,
                                             colorText: Colors.white);
                                       }else{
                                         Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,'cartPage'));
                                       }


                                     }
                                   },
                                   child: Container(
                                     width: Dimensions.width20*5,
                                     height: Dimensions.height20*5,
                                     margin: EdgeInsets.only(bottom: 10),
                                     decoration: BoxDecoration(
                                       image: DecorationImage(
                                         fit: BoxFit.cover,
                                         image: NetworkImage(
                                             '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${cartController.getItems[index].img!}'
                                         ),
                                       ),
                                       borderRadius: BorderRadius.circular(Dimensions.radius20,),
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: Dimensions.width10,
                                 ),
                                 Expanded(child: Container(
                                   height: Dimensions.height20*5,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       BigText( text: cartController.getItems[index].name?? 'No name',
                                         color: Colors.black54,),
                                       SmallText(text: 'Spicy',),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           BigText(text: '\$ ${cartController.getItems[index].price! * _cartList[index].quantity!}', color:  Colors.redAccent,),
                                           Container(
                                             // padding: EdgeInsets.all(Dimensions.height10),
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(Dimensions.radius20),

                                             ),
                                             child: Row(
                                               children: [
                                                 GestureDetector(
                                                     onTap: (){
                                                       cartController.addItem(_cartList[index].product!, -1);
                                                     },
                                                     child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                 SizedBox(width: Dimensions.width10/2,),
                                                 BigText(text: _cartList[index].quantity.toString() ),
                                                 SizedBox(width: Dimensions.width10/2,),
                                                 GestureDetector(
                                                     onTap: (){
                                                       cartController.addItem(_cartList[index].product!, 1);
                                                     },
                                                     child: Icon(Icons.add, color: AppColors.signColor,))
                                               ],
                                             ),
                                           ),
                                         ],
                                       ),


                                     ],
                                   ),
                                 ))
                               ],
                             ),
                           );
                         });
                   },),
                 ),
               )):
            NoDataPage(text: 'Your cart is empty');
         }),

        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
                vertical: Dimensions.height20),
            decoration: BoxDecoration(
              color: AppColors.bottomBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20 * 2),
                topLeft: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: cartController.getItems.length>0?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [

                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: '\$${cartController.totalAmount}'),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                  child: GestureDetector(
                    onTap: () {
                      if(Get.find<AuthController>().userLoggedIn()){
                        cartController.addToHistory();
                      }else{
                      Get.toNamed(RouteHelper.getSignInPage());
                      }

                    },
                    child: BigText(
                      text: 'Check out',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ) : Container( )
          );
        },
      ),
    );
  }
}
