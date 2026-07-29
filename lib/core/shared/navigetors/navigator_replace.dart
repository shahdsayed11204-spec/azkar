import 'package:flutter/material.dart';

 void navigatorReplace(context, widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

