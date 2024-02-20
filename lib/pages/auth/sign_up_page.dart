import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/base/custom_loader.dart';
import 'package:foo_delivery/base/show_custom_snackbar.dart';
import 'package:foo_delivery/models/signup_body_model.dart';
import 'package:foo_delivery/pages/auth/sign_in_page.dart';
import 'package:foo_delivery/routes/route_helper.dart';
import 'package:foo_delivery/utils/colors.dart';
import 'package:foo_delivery/widgets/app_text_field.dart';
import 'package:foo_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    var signUpImages=[
      't.png',
      'f.png',
      'g.png',
    ];

    void _registration(AuthController authController){
      String name=nameController.text.trim();
      String email=emailController.text.trim();
      String password=passwordController.text.trim();
      String phone=phoneController.text.trim();
      if(name.trim().isEmpty){
        showCustomSnackBar('Type in your name', title: 'Name');
      } else if(phone.trim().isEmpty){
        showCustomSnackBar('Type in your phone', title: 'Phone');

      } else if(email.trim().isEmpty){
        showCustomSnackBar('Type in your email', title: 'email');

      }else if(email.trim().isEmpty || !email.contains('@')){
        showCustomSnackBar('Type in valid email address', title: 'Valid Email address');

      }else if(password.trim().isEmpty){
        showCustomSnackBar('Type in your password', title: 'Password');

      }else if(password.trim().length<6){
        showCustomSnackBar('Password can not be less then 6 characters', title: 'Password');
      }
      else{
      SignUpBody signUpBody= SignUpBody(name: name, phone: phone, email: email, password: password);
      authController.registration(signUpBody).then((status){
        if(status.isSuccess){
         Get.offNamed(RouteHelper.getInitial());
        }else{
          showCustomSnackBar(status.message.toString());
        }
      });
      }
      
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.islLoading? SingleChildScrollView(
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
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(textController: nameController,
                  hintText: 'Name',
                  icon: Icons.person),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(textController: phoneController,
                  hintText: 'Phone',
                  icon: Icons.phone,
                  keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  height: Dimensions.screenHeight/13,
                  width: Dimensions.screenWidth/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(text: 'Sign up',
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: 'Have an account already?',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    )
                ),

              ),
              SizedBox(
                height: Dimensions.screenHeight*0.05,
              ),
              RichText(text: TextSpan(
                text: 'Sign up using one of the following methods',
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16
                ),
              ),),
              Padding(
                padding:  EdgeInsets.only(top:Dimensions.height10),
                child: Wrap(
                  spacing: Dimensions.width20,

                  children: List.generate(3, (index) => CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        'assets/images/${signUpImages[index]}'),)),
                ),
              )


            ],
          ),
        )
            : Center(child: CustomLoader());
      },)
    );

  }
}
