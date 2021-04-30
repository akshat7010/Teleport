import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/services/auth.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/constants.dart';
import 'package:teleport/shared/loading.dart';
import 'package:flutter/services.dart';
String hexString = "39c0ba";
class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String itemName = '';
  double cost = 0;
  String description = '';
  String error = '';
  String costValidator(String val){
    try{
      double.parse(val);
      return null;
    }catch(e){
      return 'Enter a valid cost.';
    }
  }
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Usr>(context);
    return StreamBuilder<UsrData>(
        stream: DatabaseService(uid: usr.uid).usrData,
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Color(int.parse("0xff${hexString}")),
                  title: Text('Add New Item'),
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
                              decoration: textInputDecoration.copyWith(hintText: 'Enter item Name'),
                              validator: (val) => val.isEmpty ? 'Enter the name of the item' : null,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.bottom,
                              onChanged: (val){
                                setState(() {
                                  itemName = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                          SizedBox(
                            // height: 50.0,
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'Enter cost'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                              validator: costValidator,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.bottom,
                              onChanged: (val){
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
                              maxLength: 300,
                              minLines: 5,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: textInputDecoration.copyWith(hintText: 'Description(optional)'),
                              textAlignVertical: TextAlignVertical.bottom,
                              onChanged: (val){
                                setState(() {
                                  description = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                            width: 250.0,
                            child: RaisedButton(
                              color: Color(int.parse("0xff${hexString}")),
                              child: Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if(_formKey.currentState.validate()){
                                  print('Success');
                                  try {
                                    DatabaseService(uid: usr.uid).addItem(
                                        itemName,
                                        cost,
                                        description,
                                        snapshot.data.businessName
                                    );
                                    Fluttertoast.showToast(
                                        msg: "Success",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.blueGrey,
                                        textColor: Colors.black,
                                        fontSize: 16.0
                                    );
                                  }catch(e){
                                    print(e.toString());
                                  }
                                  Navigator.pop(context);
                                }else{
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
                    )
                )
            );
          else
            return Loading();
        }
    );
  }
}

