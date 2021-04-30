import 'package:flutter/material.dart';
import 'package:teleport/screens/home/end/counter_view.dart';
import 'package:teleport/models/item.dart';
import 'package:teleport/screens/home/end/end.dart';
import 'package:teleport/screens/home/end/item_list.dart';
import 'package:teleport/screens/home/end/item_tile.dart';
import 'package:teleport/screens/home/end/item_view.dart';
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
      return End();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Test")
    //   ),
    //   body: SizedBox(
    //     height: 30.0,
    //     width: 150.0,
    //     child: ItemTile(
    //       item:Item(
    //         name: "PS5",
    //         shop: "Sony",
    //         cost: 5.0,
    //       )
    //     ),
    //   ),
    // );
  }
}
