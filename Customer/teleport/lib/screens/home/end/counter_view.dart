import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/cart.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/services/database.dart';
String hexString = "39c0ba";
String hexString2 = "90e6e2";
class PrimitiveWrapper {
  var value;
  PrimitiveWrapper(this.value);
}

class CounterView extends StatefulWidget {
  final PrimitiveWrapper quantity;
  final PrimitiveWrapper itemCost;
  final PrimitiveWrapper total;
  final int initNumber = 0;
  final Function callBack;
  final cost;
  CounterView({this.quantity, this.total, this.callBack, this.cost, this.itemCost});

  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int _currentCount;
  bool zero = true;

  @override
  void initState() {
    _currentCount = widget.initNumber;
    if(widget.initNumber>0) zero = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Usr usr = Provider.of<Usr>(context);
    print('usr: ');
    print(usr.uid);
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color(int.parse("0xff${hexString}")),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createIncrementDecrementButton(
              Icons.remove, () => _decrement(usr), !zero),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: zero ? Text("Add") : Text(_currentCount.toString()),
          ),
          _createIncrementDecrementButton(Icons.add, () => _increment(usr), true),
        ],
      ),
    );
  }


  void _increment(Usr usr) async {

    setState(()  {
      _currentCount++;
      widget.quantity.value++;
      widget.total.value++;
      widget.itemCost.value = widget.itemCost.value + widget.cost;
      print("current count = $_currentCount");
      if (_currentCount > 0) {
        zero = false;
      }
    });
    // widget.callBack();
  }

  void _decrement(Usr usr) async{
    setState(() {
      if (_currentCount > 0) {
        _currentCount--;
        widget.quantity.value--;
        widget.total.value--;
        widget.itemCost.value = widget.itemCost.value - widget.cost;

      }
      if (_currentCount == 0) {
        zero = true;
      }
    });
    // widget.callBack();
  }

  Widget _createIncrementDecrementButton(
      IconData icon, Function onPressed, bool vizi) {
    return Visibility(
      visible: vizi,
      child: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: Color(int.parse("0xff${hexString2}")),
        child: Icon(
          icon,
          color: Colors.black,
          size: 12.0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
