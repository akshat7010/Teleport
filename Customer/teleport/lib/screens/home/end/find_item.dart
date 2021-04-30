import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/cart.dart';
import 'package:teleport/models/item.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/end/counter_view.dart';
import 'package:teleport/screens/home/end/billing.dart';
import 'package:teleport/screens/home/end/item_list.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/constants.dart';
import 'package:teleport/shared/loading.dart';

class FindItem extends StatefulWidget {
  final UsrData shop;
  final Item item;
  final Future<List<Item>> itemsFuture;
  FindItem({this.shop, this.itemsFuture, this.item});

  @override
  _FindItemState createState() => _FindItemState();
}

class _FindItemState extends State<FindItem> {
  List<Item> currentItems = [];
  Map<String, PrimitiveWrapper> quantities = Map();
  PrimitiveWrapper total = PrimitiveWrapper(0);
  @override
  Widget build(BuildContext context) {
    Usr usr = Provider.of<Usr>(context);
    print("total: ${total.value}");
    String hexString = "39c0ba";
    return FutureBuilder(
        future: widget.itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Item> items = snapshot.data;
            items.forEach((item) {quantities[item.name]=PrimitiveWrapper(0); quantities[item.name+'___Price']=PrimitiveWrapper(0);});
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.shop.businessName),
                backgroundColor: Color(int.parse("0xff${hexString}")),
              ),
              floatingActionButton: Visibility(
                visible: true,
                child: FloatingActionButton(
                  child: Text("BUY"),
                  backgroundColor: Color(int.parse("0xff${hexString}")),
                  onPressed: (){
                    if(total.value>0){
                      // quantities.forEach((key, value) {
                      //   if(value.value==0)
                      //     quantities.remove(key);
                      // })
                      //MARK THIS
                      // DatabaseService(uid: usr.uid).addOrder(
                      //   Cart(
                      //     uid: usr.uid,
                      //     shopUID: widget.shop.uid,
                      //     list: quantities,
                      //   ),
                      // );
                      // setState((){
                      //   items.forEach((item) {quantities[item.name]=PrimitiveWrapper(0);});
                      // });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Billing(
                                quantities: quantities,
                                shop: widget.shop,
                              ),
                          ),
                      );
                    }
                  },
                ),
              ),
              backgroundColor: Colors.black,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      onChanged: (val) {
                        currentItems = [];
                        items.forEach((item) {
                          if (item.name.startsWith(val))
                            setState(() {
                              currentItems.add(item);
                            });
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Find what you need...',
                        prefixIcon: IconButton(
                          onPressed: () {},
                          color: Colors.black,
                          icon: Icon(Icons.search),
                          iconSize: 25.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        contentPadding: EdgeInsets.only(left: 25.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ItemList(
                      items: currentItems.length == 0 ? items : currentItems,
                      quantities: quantities,
                      total: total,
                      callBack: this.setState,
                    ),
                  ),
                ],
              ),
            );
          } else
            return Loading();
        });
  }
}