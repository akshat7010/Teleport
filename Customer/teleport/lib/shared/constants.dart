import 'package:flutter/material.dart';
String hexString = "39c0ba";
  final textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color:Color(int.parse("0xff${hexString}")), width: 2.5),
  ),
  focusedBorder: OutlineInputBorder(

      borderSide: BorderSide(color:Colors.deepOrange, width: 4.0)
  ),
);