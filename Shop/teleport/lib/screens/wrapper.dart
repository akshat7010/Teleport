import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/authenticate/authenticate.dart';
import 'package:teleport/shared/loading.dart';
import 'package:teleport/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Usr>(context);

    if(usr == null)
      return Authenticate();
    else
      return Home(type: 'shop');
  }
}
