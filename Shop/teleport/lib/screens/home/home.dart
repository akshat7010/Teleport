import 'package:flutter/material.dart';
import 'package:teleport/screens/home/root/add_new_item.dart';
import 'package:teleport/screens/home/root/root.dart';
import 'package:teleport/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  final String type;

  Home({this.type});
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context){
    return Root();
  }
}
