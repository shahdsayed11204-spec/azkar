import 'package:flutter/material.dart';

  void Navigatendfinish( context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic>route)=>false,
  );
