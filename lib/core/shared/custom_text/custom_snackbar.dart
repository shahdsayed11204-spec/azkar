import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'coustom_taxt.dart';

SnackBar customSnack({required String msg,final Color?color,IconData? icon}) {
  return SnackBar(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(
      bottom: 5,
      left: 20,
      right: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 5,
    backgroundColor: color,
    content: Row(
      children: [
         Icon(
          icon ?? CupertinoIcons.info_circle,color: Colors.white,size: 12,
        ),
        const Gap(10),
        Expanded(
          child: CustomText(
            text: msg,
            size: 11,
            font: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}