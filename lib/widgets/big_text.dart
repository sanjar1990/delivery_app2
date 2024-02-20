import 'package:flutter/cupertino.dart';

import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overflow;

   const BigText(
      {super.key,
      this.color= const Color(0xff332d2b),
      required this.text,
      this.size =0,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size==0? Dimensions.font20:size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400
      ) ,
      maxLines: 1,
      overflow: overflow,
    );
  }
}
