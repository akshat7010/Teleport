import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:Deliver/models/user.dart';

class ThingTile extends StatefulWidget {

  final String thing;
  final int quantity;
  ThingTile({this.thing, this.quantity});

  @override
  _ThingTileState createState() => _ThingTileState();
}

class _ThingTileState extends State<ThingTile> {
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserM>(context);
    return Container(
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('assets/item.png'),
            ),
            title: Text(widget.thing),
            trailing: Text(widget.quantity.toString()),
          ),
        ),
    );
  }
}
