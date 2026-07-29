import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomText({
  required String text,
   Color ?color,
   FontWeight? font,
   double? size,
  TextDecoration? decoration,
})=> Text(
  text,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  textAlign: TextAlign.right,
  textScaler: TextScaler.linear(1.0),
  style: TextStyle(
    fontWeight: font,
    fontSize: size,
    color: color,
    decoration: decoration,
  ),
);