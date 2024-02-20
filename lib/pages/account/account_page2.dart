import 'package:flutter/material.dart';
import 'package:foo_delivery/base/custom_loader.dart';
import 'package:foo_delivery/controllers/auth_controller.dart';
import 'package:foo_delivery/controllers/cart_controller.dart';
import 'package:foo_delivery/controllers/user_controller.dart';
import 'package:foo_delivery/pages/auth/sign_in_page.dart';
import 'package:foo_delivery/routes/route_helper.dart';
import 'package:foo_delivery/utils/colors.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:foo_delivery/widgets/account_widget.dart';
import 'package:foo_delivery/widgets/app_icon.dart';
import 'package:foo_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage2 extends StatelessWidget {
  const AccountPage2({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print('user logged in');
    }
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: 'Profile'),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: GetBuilder<UserController>(builder: (userController){


        return  Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //photo
              AppIcon(
                icon: Icons.person,
                size: Dimensions.height15*10,
                iconSize: Dimensions.height15*5,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
              SizedBox(height: Dimensions.height30,),
              Expanded(child: SingleChildScrollView(
                child: Column(children: [
                  // name
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.person,
                      size: Dimensions.height10*5,
                      iconSize: Dimensions.icon24,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ) ,
                    bigText: BigText(text: userController.userModel.name),
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //phone
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.phone,
                      size: Dimensions.height10*5,
                      iconSize: Dimensions.icon24,
                      backgroundColor: AppColors.yellowColor,
                      iconColor: Colors.white,
                    ) ,
                    bigText: BigText(text: userController.userModel.phone),
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //email
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.email,
                      size: Dimensions.height10*5,
                      iconSize: Dimensions.icon24,
                      backgroundColor: AppColors.yellowColor,
                      iconColor: Colors.white,
                    ) ,
                    bigText: BigText(text: userController.userModel.email),
                  ),
                  SizedBox(height: Dimensions.height20,),
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.location_on,
                      size: Dimensions.height10*5,
                      iconSize: Dimensions.icon24,
                      backgroundColor: AppColors.yellowColor,
                      iconColor: Colors.white,
                    ) ,
                    bigText: BigText(text: 'your address'),
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //messages
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.message_outlined,
                      size: Dimensions.height10*5,
                      iconSize: Dimensions.icon24,
                      backgroundColor: Colors.redAccent,
                      iconColor: Colors.white,
                    ) ,
                    bigText: BigText(text: 'Message'),
                  ),
                  //logOut
                  GestureDetector(
                    onTap: (){
                      if(Get.find<AuthController>().userLoggedIn()){
                        Get.find<AuthController>().clearSharedData();
                        Get.find<CartController>().clearCartHistory();
                        Get.find<CartController>().clear();
                        Get.offNamed(RouteHelper.getSignInPage());
                      }

                    },
                    child: AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.logout,
                        size: Dimensions.height10*5,
                        iconSize: Dimensions.icon24,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                      ) ,
                      bigText: BigText(text: 'Logout'),
                    ),
                  ),

                ],),
              ))
            ],
          ),
        );
      },)
    );
  }
}
