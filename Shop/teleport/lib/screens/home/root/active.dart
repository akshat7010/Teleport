import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/order.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/root/active_order_list.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/loading.dart';

import 'item_list.dart';

class Active extends StatefulWidget {
  @override
  _ActiveState createState() => _ActiveState();
}

class _ActiveState extends State<Active> {

  @override
  Widget build(BuildContext context) {
    Usr usr = Provider.of<Usr>(context);
    return StreamBuilder(
        stream: DatabaseService(uid: usr.uid).activeOrders,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            try{
              print(snapshot.data);
              return Column(mainAxisAlignment: MainAxisAlignment.start,children:[Expanded(child: OrderList(orders: snapshot.data))]);
            }catch(e){
              return null;
            }
          }
          else
            return Loading();
        }
    );
  }
}
