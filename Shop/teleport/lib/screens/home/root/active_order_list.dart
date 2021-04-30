import 'package:flutter/material.dart';
import 'package:teleport/models/order.dart';
import 'package:teleport/screens/home/root/active_order_tile.dart';

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
      // mainAxisAlignment: MainAxisAlignment.start,
      // children: [
        // SizedBox(height: 5.0),
        // SingleChildScrollView(
          // child: Expanded(
         ListView.builder(
          shrinkWrap: true,
          itemCount: widget.orders.length,
          itemBuilder: (context, index){
            return OrderTile(order: widget.orders[index]);
          },
        // ),
          // ),
        );

  }
}
