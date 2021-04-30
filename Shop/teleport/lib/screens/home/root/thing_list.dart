import 'package:flutter/material.dart';
import 'package:teleport/models/order.dart';
import 'package:teleport/screens/home/root/order_tile.dart';
import 'package:teleport/screens/home/root/thing_tile.dart';

class ThingList extends StatefulWidget {

  final  Order order;
  ThingList({this.order});
  @override
  _ThingListState createState() => _ThingListState();
}

class _ThingListState extends State<ThingList> {
  @override
  Widget build(BuildContext context) {
   // widget.order.remove("cost");
    List<String> stuffName = List();
    List<int> stuffQuantity = List();
    widget.order.list.forEach((key, value) {
      stuffName.add(key);
      stuffQuantity.add(value);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.name),
        backgroundColor: Colors.blueAccent[700],
      ),
      backgroundColor: Colors.black,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: stuffName.length,
              itemBuilder: (context, index){
                return ThingTile(thing: stuffName[index], quantity: stuffQuantity[index]);
              },
            ),
          ],
        ),
    );
  }
}
