import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:teleport/models/order.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/root/thing_list.dart';

class OrderTile extends StatefulWidget {
  final Order order;
  OrderTile({this.order});

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Usr>(context);
    return Container(
      // padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThingList(order: widget.order)),
          );
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15.0),
          // ),
          // color: Colors.white,
          child:
          ListTile(
            title: Text(widget.order.name),
          ),

        ),
      ),
    );
  }
}