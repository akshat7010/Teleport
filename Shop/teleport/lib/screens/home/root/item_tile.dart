import 'package:provider/provider.dart';
import 'package:teleport/models/item.dart';
import 'package:flutter/material.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/root/edit_item.dart';
import 'package:teleport/services/database.dart';

class ItemTile extends StatefulWidget {

  final Item item;

  ItemTile({this.item});

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditItem(uid: widget.item.uid)),
          );
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('assets/item.png'),
            ),
            title: Text(widget.item.name),
            subtitle: Text('Costs ${widget.item.cost}'),
          ),
        ),
      ),
    );
  }
}
