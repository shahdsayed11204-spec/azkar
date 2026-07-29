import 'package:flutter/material.dart';

class CustomTextformfiled extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final Color ? color;
  final Color ? textcolor;
  final TextInputType ? type;
  final String ? Function(String?)?validator;
  final IconData ?prefix;
  final IconData ?sufix;
 final VoidCallback? suffixprex;



  const CustomTextformfiled({ required this.hint,
    required this.controller,
    this.color, this.textcolor,
    this.type, required this.isPassword,
    this.validator,
    this.prefix,
    this.sufix,
    this.suffixprex
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: isPassword,
      controller: controller,
      cursorColor: Colors.white,
      keyboardType: type,
      cursorHeight: 20,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hint,
        hintStyle: TextStyle(
            color: textcolor??Colors.white
        ),
        fillColor: Colors.transparent,
        filled: true,
        prefixIcon: Icon(prefix,color: Colors.white,),
        suffixIcon: sufix!=null ?IconButton(onPressed: suffixprex, icon: Icon(sufix,color: Colors.white)):null,

      ),

    );
  }
}