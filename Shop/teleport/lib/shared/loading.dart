import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
String hexString = "39c0ba";
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SpinKitWanderingCubes(
          color: Color(int.parse("0xff${hexString}")),
          size: 50.0,
        ),
      ),
    );
  }
}
