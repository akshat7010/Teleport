import 'package:flutter/material.dart';
import 'package:teleport/screens/home/root/add_new_item.dart';
import 'package:teleport/screens/home/root/item_list.dart';

class Shelf extends StatefulWidget {
  @override
  _ShelfState createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.016,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.05,
          child: FlatButton.icon(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewItem()),
              );
            },
            icon: Icon(Icons.add),
            label: Text('Add new Item'),
            color: Colors.blueGrey,
          ),
        ),
        Expanded(
          child: ItemList(),
        ),
      ],
    );
  }
}
