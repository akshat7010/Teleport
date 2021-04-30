import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/cart.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/constants.dart';

class FinalizeOrder extends StatefulWidget {
  final quantities;
  final shop;
  final cost;
  FinalizeOrder({this.quantities, this.shop, this.cost});

  @override
  _FinalizeOrderState createState() => _FinalizeOrderState();
}

class _FinalizeOrderState extends State<FinalizeOrder> {
  final _formKey = GlobalKey<FormState>();
  String address;
  String phone;

  @override
  Widget build(BuildContext context) {
    String hexString = "39c0ba";
    final usr = Provider.of<Usr>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.name),
        backgroundColor: Color(int.parse("0xff${hexString}")),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 50.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(height: 20.0),
              SizedBox(
                  // height: 50.0,
                  child: TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Enter 10-digit phone number'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    validator: (val) =>
                        (val.length != 10) ? 'Enter your phone number.' : null,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                  )),
              SizedBox(height: 20.0),
              SizedBox(
                  child: TextFormField(
                maxLength: 300,
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: textInputDecoration.copyWith(hintText: 'Enter complete address'),
                validator: (val) =>
                    (val.length == 0) ? 'Address can not be null.' : null,
                textAlignVertical: TextAlignVertical.bottom,
                onChanged: (val) {
                  setState(() {
                    address = val;
                  });
                },
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.6,
                child: RaisedButton(
                  color: Color(int.parse("0xff${hexString}")),
                  child: Text(
                    'Place Order',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try{
                        await DatabaseService(uid: usr.uid).addOrder(
                          Cart(
                              uid:usr.uid,
                              shopUID: widget.shop.uid,
                              shopAddress: widget.shop.address,
                              list: widget.quantities,
                              customerAddress: address,
                              phone: phone,
                              shopName: widget.shop.name,
                              cost: widget.cost,
                          ),
                        );
                        Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                      catch(e){
                        print(e.toString());
                      }
                    }
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
