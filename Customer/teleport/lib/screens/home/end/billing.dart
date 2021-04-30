import 'package:flutter/material.dart';
import 'package:teleport/screens/home/end/finalize_order.dart';

//accept quantities so that you can display it here
class Billing extends StatefulWidget {
  final Map<String, dynamic> quantities;
  final shop;
  Billing({this.quantities, this.shop});
  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];
    double total = 0;
    tableRows.add(TableRow(
      children: [
        Text(
          'Name',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        Text(
          'Quantity',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        Text(
          'Cost',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ],
    ));
    tableRows.add(TableRow(children: [
      Text(''),
      Text(''),
      Text(''),
    ]));

    // final filteredMap = new Map.fromIterable(widget.quantities.keys.where((k)=>(widget.quantities[k].value!=0)));

    widget.quantities.forEach((key, value) {
      // if(value.value==0){
      //   widget.quantities.remove(key);
      // }
      if (!(key.length > 8 && key.substring(key.length - 8) == '___Price') &&
          value.value != 0) {
        var x = widget.quantities[key + '___Price'].value;
        tableRows.add(TableRow(
          children: [
            Text(
              key,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              value.value.toString(),
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Rs. '+ x.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
        tableRows.add(TableRow(children: [
          Text(''),
          Text(''),
          Text(''),
        ]));
        total += x;
      }
    });
    tableRows.add(TableRow(
      children: [
        Text(''),
        Text(
          'Total:',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        Text(
          'Rs. '+ total.toString(),
          style: TextStyle(color: Colors.deepOrange),
        ),
      ],
    ));
    String hexString = "39c0ba";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.shop.name),
          backgroundColor: Color(int.parse("0xff${hexString}")),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Column(
            children: [
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Table(
                  children: tableRows,
                ),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FinalizeOrder(
                              quantities: widget.quantities,
                              shop: widget.shop,
                              cost: total)),
                    );
                  },
                  icon: Icon(Icons.arrow_right_outlined,
                      size: MediaQuery.of(context).size.height * 0.04),
                  label: Text('Confirm'),
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
