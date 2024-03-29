import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:foo_delivery/widgets/app_icon.dart';
import 'package:foo_delivery/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  const AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding:  EdgeInsets.only(
          left: Dimensions.width20,
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow:[ BoxShadow(
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          blurRadius: 2
        ),
        ]
            

      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText,
        ],
      ),
    );
  }
}
