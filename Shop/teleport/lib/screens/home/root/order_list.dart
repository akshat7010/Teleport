import 'package:flutter/material.dart';
import 'package:teleport/models/order.dart';
import 'package:teleport/screens/home/root/order_tile.dart';

class OrderList extends StatefulWidget {

  final List<dynamic> orders;
  OrderList({this.orders});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return
        Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.orders.length,
              itemBuilder: (context, index){
                return OrderTile(order: widget.orders[index]);
              },
    ),
          ],
        );
  }
}
