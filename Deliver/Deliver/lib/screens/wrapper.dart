//import 'package:deliver/screens/home/home.dart';
import 'package:Deliver/models/user.dart';
import 'package:Deliver/screens/authenticate/authentication.dart';
import 'package:Deliver/screens/authenticate/register.dart';
import 'package:Deliver/screens/authenticate/sign_in.dart';
import 'package:Deliver/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserM>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}