import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/item.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/services/auth.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/constants.dart';
import 'package:teleport/shared/loading.dart';
import 'package:flutter/services.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

class EditItem extends StatefulWidget {
  final String uid;
  EditItem({this.uid});
  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = true;
  bool outOfStock;
  String name;
  double cost;
  String description;
  String error = '';
  String costValidator(String val) {
    try {
      double.parse(val);
      return null;
    } catch (e) {
      return 'Enter a valid cost.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Usr>(context);

    return FutureBuilder(
      future: DatabaseService(uid: usr.uid).getItem(widget.uid),
      builder: (context, snapshot) {
        if(snapshot.hasData==false)
          return Loading();

        Item item = snapshot.data;

        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.blueAccent[700],
              title: Text('Edit Item'),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      SizedBox(
                        // height: 50.0,
                        child: TextFormField(
                          initialValue: item.name,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Item Name'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter the name of the item' : null,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        // height: 50.0,
                        child: TextFormField(
                          initialValue: item.cost.toString(),
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Cost'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                          ],
                          validator: costValidator,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (val) {
                            setState(() {
                              cost = double.parse(val);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        // height: 300.0,
                        child: TextFormField(
                          initialValue: item.description,
                          maxLength: 300,
                          minLines: 5,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: textInputDecoration.copyWith(
                              hintText: '                 Description(optional)'),
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (val) {
                            setState(() {
                              description = val;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: CheckboxListTileFormField(
                          title: Text('Out of Stock'),
                          initialValue: item.outOfStock,
                          onSaved: (val){
                            setState(() {
                              outOfStock = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        height: 50.0,
                        width: 250.0,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.save, color: Colors.white,),
                          color: Colors.deepOrange,
                          label: Text(
                            'Save Changes',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print('Success');
                              try {
                                print(name);
                                print(cost);
                                print('hey');
                                print(outOfStock);
                                DatabaseService(uid: usr.uid).editItem(
                                    name ?? item.name,
                                    cost ?? item.cost,
                                    description ?? item.description,
                                    outOfStock ?? item.outOfStock,
                                    widget.uid
                                );
                                Fluttertoast.showToast(
                                    msg: "Success",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blueGrey,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              } catch (e) {
                                print(e.toString());
                              }
                              Navigator.pop(context);
                            } else {
                              print('Error');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      SizedBox(
                        height: 50.0,
                        width: 250.0,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.delete),
                          color: Colors.redAccent[700],
                          label: Text(
                            'Delete Item',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print('Success');
                              try {
                                DatabaseService(uid: usr.uid).deleteItem(widget.uid);
                                Fluttertoast.showToast(
                                    msg: "Deleted",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blueGrey,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              } catch (e) {
                                print(e.toString());
                              }
                              Navigator.pop(context);
                            } else {
                              print('Error');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                )));
      }
    );
  }
}
