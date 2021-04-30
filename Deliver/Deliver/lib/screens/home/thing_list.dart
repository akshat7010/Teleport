import 'package:Deliver/services/database.dart';
import 'package:flutter/material.dart';
import 'package:Deliver/models/order.dart';
import 'package:Deliver/screens/home/processing_tile.dart';
import 'package:Deliver/screens/home/thing_tile.dart';
import 'package:Deliver/models/processing.dart';

class ThingList extends StatefulWidget {
  final Processing thing;
  final Function callBack;
  ThingList({this.thing,this.callBack});
  @override
  _ThingListState createState() => _ThingListState();
}

class _ThingListState extends State<ThingList> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Order Information'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () {})
        ],
      ),
      body: new Column(
        children: <Widget>[

          new ListTile(
            leading: const Icon(Icons.label),
            title: const Text('From'),
            subtitle:  Text(widget.thing.shopAddress),
          ),
          new ListTile(
            leading: const Icon(Icons.label),
            title: const Text('To'),
            subtitle: Text(widget.thing.customerAddress),
          ),
          const Divider(
            height: 1.0,
          ),
          Visibility(
            child: new ListTile(
              leading: const Icon(Icons.domain_sharp),
              title: const Text('Select Order'),

              onTap: (){
                setState(() {
                  widget.thing.state=1;
                  DataBaseService('').selectOrder(widget.thing);
                });
              },
            ),
            visible: widget.thing.state==0,
          ),
          Visibility(
            child: new ListTile(
                leading: const Icon(Icons.domain_sharp),
                title: const Text('Order Picked'),

                onTap: (){
                  setState(() {
                    widget.thing.state=2;
                    DataBaseService('').pickOrder(widget.thing);
                  });
                },
            ),
            visible: widget.thing.state==1,
          ),
          Visibility(
          child: new ListTile(
              leading: const Icon(Icons.domain_sharp),
              title: const Text('Payment Received'),

              onTap: (){


                 DataBaseService('').deliverOrder(widget.thing);
                //await widget.callBack();
                Navigator.pop(context);


              print("wubbalubbadubdub");

              },
          ),
            visible: widget.thing.state==2,
          ),
        ],
      ),
    );
  }
}
