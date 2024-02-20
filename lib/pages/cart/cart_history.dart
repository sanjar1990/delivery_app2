import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/base/no_data_page.dart';
import 'package:foo_delivery/controllers/cart_controller.dart';
import 'package:foo_delivery/models/cart_model.dart';
import 'package:foo_delivery/routes/route_helper.dart';
import 'package:foo_delivery/utils/app_constants.dart';
import 'package:foo_delivery/utils/colors.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:foo_delivery/widgets/app_icon.dart';
import 'package:foo_delivery/widgets/big_text.dart';
import 'package:foo_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList=Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder=Map();
    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }
    List<int> itemsPerOrder=cartItemsPerOrderToList();
    var listCounter=0;
    Widget timeWidget(int index){
      var outPutDate=DateTime.now().toString();
      if(index<getCartHistoryList.length){
        var outputFormat=DateFormat('MM/dd/yyyy hh:mm a');
         outPutDate=outputFormat.format(DateTime.parse(getCartHistoryList[listCounter].time!));
      }

      return BigText(text: outPutDate);
    }
    return Scaffold(
    body: Column(
      children: [
        Container(
          height: Dimensions.height20*5,
          color: AppColors.mainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(text: 'CartHistory'),
              AppIcon(icon: Icons.shopping_cart_outlined, iconColor: AppColors.mainColor,
              backgroundColor: AppColors.iconColor1,)
            ],
          ),
        ),
       GetBuilder<CartController>(builder: (_cartController){

         return _cartController.getCartHistoryList().length>0? Expanded(
           child: Container(
             margin: EdgeInsets.only(
               top: Dimensions.height20,
               left: Dimensions.width20,
               right: Dimensions.width20,
             ),
             child: MediaQuery.removePadding(
                 removeTop: true,
                 context: context,
                 child: ListView(
                   children: [
                     for(int i=0; i<itemsPerOrder.length; i++)
                       Container(
                         height: Dimensions.height10*13,
                         margin:EdgeInsets.only(bottom: Dimensions.height20),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             timeWidget(listCounter),
                             SizedBox(height: Dimensions.height10/2,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Wrap(
                                   direction: Axis.horizontal,
                                   children: List.generate(itemsPerOrder[i], (index) {
                                     if(listCounter<getCartHistoryList.length){
                                       listCounter++;
                                     }
                                     return index<=2 ?Container(
                                       width: Dimensions.width20*4,
                                       height: Dimensions.height20*4,
                                       margin: EdgeInsets.only(right: Dimensions.width10/2),
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                         image: DecorationImage(
                                           image: NetworkImage(
                                               AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                           ),
                                         ),
                                       ),
                                     ) :Container();
                                   }),
                                 ),
                                 Container(
                                   height: Dimensions.height20*4+5,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       SmallText(text: 'Total', color: AppColors.titleColor,),
                                       BigText(text: '${itemsPerOrder[i]} Items', color: AppColors.titleColor,),
                                       GestureDetector(
                                         onTap: (){
                                           var orderTime=cartOrderTimeToList();
                                           Map<int, CartModel> moreOrder={};
                                           for(int j=0; j<getCartHistoryList.length; j++){
                                             if(getCartHistoryList[j].time==orderTime[i]){
                                               moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                   CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                             }
                                           }
                                           Get.find<CartController>().setItems=moreOrder;
                                           Get.find<CartController>().addToCartList();
                                           Get.toNamed(RouteHelper.getCartPage(0, 'cartHistory'));
                                         } ,
                                         child: Container(
                                           padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                               vertical: Dimensions.height10/2),
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                               border: Border.all(width: 1, color: AppColors.mainColor)
                                           ),
                                           child: SmallText(
                                             text: 'One more',color: AppColors.mainColor,
                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                 )
                               ],
                             )

                           ],
                         ),
                       )
                   ],
                 )),
           ),
         )
             : NoDataPage(text: 'You didn''t buy anything',
         imgPath: 'assets/images/empty_box.png',);
       },)
      ],
    ),
    );
  }
}
