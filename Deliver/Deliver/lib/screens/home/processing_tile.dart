import 'package:Deliver/models/processing.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:Deliver/models/order.dart';
import 'package:Deliver/models/user.dart';
import 'package:Deliver/screens/home/thing_list.dart';

class ProcessingTile extends StatefulWidget {
  final Processing processing;
  final Function callBack;
  ProcessingTile({this.processing,this.callBack});

  @override
  _ProcessingTileState createState() => _ProcessingTileState();
}

class _ProcessingTileState extends State<ProcessingTile> {

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserM>(context);
    return Container(
      // padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThingList(thing: widget.processing,callBack: widget.callBack,)),
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
                title: Text(widget.processing.shopName),
                trailing: Text(widget.processing.time),
              ),

        ),
      ),
    );
  }
}
