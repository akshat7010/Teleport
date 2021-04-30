import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/item.dart';
import 'package:teleport/screens/home/end/counter_view.dart';
import 'package:teleport/screens/home/end/item_tile.dart';

class ItemList extends StatefulWidget {

  final List<Item> items;
  final Map quantities;
  final total;
  final Function callBack;
  ItemList({this.items, this.quantities, this.total, this.callBack});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index){

        return ItemTile(item: widget.items[index], quantity: widget.quantities[widget.items[index].name], cost: widget.quantities[widget.items[index].name + '___Price'], total: widget.total, callBack: widget.callBack);
      },
    );
  }
}
