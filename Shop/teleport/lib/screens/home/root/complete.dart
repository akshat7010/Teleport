import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/order.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/root/order_list.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/loading.dart';

class Complete extends StatefulWidget {
  @override
  _CompleteState createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {

  @override
  Widget build(BuildContext context) {
    Usr usr = Provider.of<Usr>(context);
    return StreamBuilder(
        stream: DatabaseService(uid: usr.uid).completeOrders,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            try{
              print(snapshot.data);
              return OrderList(orders: snapshot.data);
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
