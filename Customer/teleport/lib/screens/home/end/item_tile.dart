import 'package:provider/provider.dart';
import 'package:teleport/models/item.dart';
import 'package:flutter/material.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/end/counter_view.dart';
import 'package:teleport/screens/home/end/item_view.dart';

class ItemTile extends StatefulWidget {
  final Item item;
  final PrimitiveWrapper quantity;
  final PrimitiveWrapper cost;
  final PrimitiveWrapper total;
  final Function callBack;
  ItemTile({this.item, this.quantity, this.total, this.callBack, this.cost});

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Usr>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('assets/item.png'),
              ),
              title: InkWell(
                onTap: () {
                  setState(() {
                    show = !show;
                  });
                },
                child: Text(widget.item.name),
              ),
              subtitle: Text('Costs ${widget.item.cost}'),
              trailing: SizedBox(
                height: 30.0,
                width: 96.0,
                child: CounterView(
                  quantity: widget.quantity,
                  total: widget.total,
                  itemCost: widget.cost,
                  cost: widget.item.cost,
                  callBack: widget.callBack,
                ),
              ),
            ),
            Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 40.0),
                        Text(
                            widget.item.description,
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                  ],
                ),
                visible: show
            ),
          ],
        ),
      ),
    );
  }
}
