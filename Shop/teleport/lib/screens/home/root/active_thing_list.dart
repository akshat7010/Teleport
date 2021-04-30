import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/order.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/root/order_tile.dart';
import 'package:teleport/screens/home/root/thing_tile.dart';
import 'package:teleport/services/database.dart';

class ThingList extends StatefulWidget {

  final Order order;
  ThingList({this.order});
  @override
  _ThingListState createState() => _ThingListState();
}

class _ThingListState extends State<ThingList> {
  @override
  Widget build(BuildContext context) {
    Usr usr = Provider.of<Usr>(context);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Column(
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
            Container(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: RaisedButton(
                            color: Colors.green,
                            onPressed: (){
                              DatabaseService(uid: usr.uid).acceptOrder(widget.order);
                              Navigator.pop(context);
                            },
                            child:Text('Accept',
                              style: TextStyle(color: Colors.white),)
                        ),
                      ),
                      SizedBox(
                        width:MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: RaisedButton(
                            color: Colors.red,
                            onPressed: (){
                              DatabaseService(uid: usr.uid).deleteOrder(widget.order.uid);
                              Navigator.pop(context);
                            },
                            child:Text('Decline',
                              style: TextStyle(color: Colors.white),)
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5.0),
                ],
              ),

            ),
          ],

      ),
    );
  }
}
