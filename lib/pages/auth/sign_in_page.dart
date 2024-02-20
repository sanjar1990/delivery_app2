import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/base/custom_loader.dart';
import 'package:foo_delivery/pages/auth/sign_up_page.dart';
import 'package:foo_delivery/pages/home/home_page.dart';
import 'package:foo_delivery/routes/route_helper.dart';
import 'package:foo_delivery/utils/app_constants.dart';
import 'package:foo_delivery/utils/colors.dart';
import 'package:foo_delivery/widgets/app_text_field.dart';
import 'package:foo_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();

    void _login(AuthController authController){
      String email=emailController.text.trim();
      String password=passwordController.text.trim();

      if(email.trim().isEmpty){
        showCustomSnackBar('Type in your email', title: 'email');

      }else if(email.trim().isEmpty || !email.contains('@')){
        showCustomSnackBar('Type in valid email address', title: 'Valid Email address');

      }else if(password.trim().isEmpty){
        showCustomSnackBar('Type in your password', title: 'Password');

      }else if(password.trim().length<6){
        showCustomSnackBar('Password can not be less then 6 characters', title: 'Password');
      }
      else{

        authController.login(email,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getCartPage(1, 'recommendedPage'));
            print('logged in');
          }else{
            showCustomSnackBar(status.message.toString());
          }
        });
      }

    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.islLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight*0.05,
              ),
              Container(
                child: Center(
                  child: CircleAvatar(
                    radius: 80 ,
                    backgroundImage: AssetImage('assets/images/logo part 1.png'),
                  ),
                ),
              ),
              //welcome
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello',
                      style: TextStyle(
                          fontSize: (Dimensions.font20*4)-5,
                          fontWeight: FontWeight.bold
                      ),),
                    RichText(
                      text: TextSpan(
                          text: 'Sign into you account',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20*2,
              ),
              AppTextField(textController: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(textController: passwordController,
                hintText: 'Password',
                icon: Icons.password,
                isObscure: true,
              ),


              SizedBox(height: Dimensions.height20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end ,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Sign into your account',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    ),
                  ),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(
                height: Dimensions.screenHeight*0.05,
              ),
              GestureDetector(
                onTap: (){
                  _login(_authController);
                },
                child: Container(
                  height: Dimensions.screenHeight/13,
                  width: Dimensions.screenWidth/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(text: 'Sign in',
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.screenHeight*0.05,
              ),
              RichText(text: TextSpan(
                  text: 'Don''t have an account? ',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpPage(), transition: Transition.fadeIn),
                      text: 'Create ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ]
              ),),

            ],
          ),
        )
            :CustomLoader();
      },)
    );
  }
}
