
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constant/api_color.dart';
import 'coustom_taxt.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.height,
    this.radius,
    this.textColor,
    this.widget,
    this.gap, this.icon,
    required this.colum1,
    required this.colum2,
  });

  final String text,colum1,colum2;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final Color? textColor;
  final Widget? widget;
  final double? gap;
  final IconData?icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          color: color ?? ApiColor.primary,
          borderRadius: BorderRadius.circular(radius ?? 10),
            border: Border.all(
        color: Colors.white60.withOpacity(0.5),
      ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(text: text, color: textColor ?? Colors.white, size: 18, font: FontWeight.w500),
                Spacer(),
                Icon(icon,color: Colors.white,size: 25,),
                Gap(gap ?? 0.0),
                widget ?? SizedBox.shrink(),

              ],
            ),
            Column(
              children: [
                CustomText(text: colum1, color: textColor ?? Colors.white, size: 15, font: FontWeight.w500),
                CustomText(text: colum2, color: textColor ?? Colors.white, size: 15, font: FontWeight.w500),
              ],
            ),
          ],
        ),

      ),
    );
  }
}