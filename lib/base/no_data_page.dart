import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:foo_delivery/widgets/small_text.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage(
      {super.key,
      required this.text,
      this.imgPath = 'assets/images/empty_cart.png'});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imgPath,
        height: MediaQuery.of(context).size.height*0.50,
        width: MediaQuery.of(context).size.width*0.50,
        ),
        // SizedBox(height: Dimensions.height15,),
        Text( text,
        style: TextStyle(
          color: Theme.of(context).disabledColor,
          fontSize: MediaQuery.of(context).size.height*0.0175
        ),),
      ],
    ),);
  }
}
