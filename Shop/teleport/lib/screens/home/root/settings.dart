import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/services/auth.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/constants.dart';
import 'package:teleport/shared/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
String hexString = "39c0ba";
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String name;
  String phone;
  String email;
  String address;
  @override
  Widget build(BuildContext context) {

    final usr = Provider.of<Usr>(context);

    return StreamBuilder<UsrData>(
      stream: DatabaseService(uid: usr.uid).usrData,
      builder: (context, snapshot){
        if(snapshot.hasData) {
          UsrData usrData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
              backgroundColor: Color(int.parse("0xff${hexString}")),
            ),
              backgroundColor: Colors.black,
              body: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          SizedBox(
                            height: 50.0,
                            child: TextFormField(
                              initialValue: usrData.name,
                              decoration:
                              textInputDecoration.copyWith(hintText: 'Name'),
                              validator: (val) =>
                              val.isEmpty ? 'Enter the name of your store' : null,
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
                            height: 50.0,
                            child: TextFormField(
                              initialValue: usrData.phone,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Contact Number'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                              ],
                              validator: (val) =>
                              val.isEmpty
                                  ? 'Enter the contact number of your store'
                                  : null,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.bottom,
                              onChanged: (val) {
                                setState(() {
                                  phone = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                      TextFormField(
                              initialValue: usrData.email,
                              decoration:
                              textInputDecoration.copyWith(hintText: 'email'),
                              textAlign: TextAlign.center,
                              validator: (val) =>
                                val.isEmpty ? 'Enter your email' : null,
                              textAlignVertical: TextAlignVertical.bottom,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                          SizedBox(height: 20.0),
                          SizedBox(
                            height: 50.0,
                            child: TextFormField(
                              initialValue: usrData.address,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Address'),
                              keyboardType: TextInputType.streetAddress,

                              validator: (val) =>
                              val.isEmpty
                                  ? 'Enter the address of your store'
                                  : null,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.bottom,
                              onChanged: (val) {
                                setState(() {
                                  address = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 50.0,
                            width: 250.0,
                            child: RaisedButton(
                              color: Color(int.parse("0xff${hexString}")),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try{
                                    await DatabaseService(uid: usr.uid)
                                .updateUsrData(
                                      name ?? usrData.name,
                                      phone ?? usrData.phone,
                                      email ?? usrData.email,
                                      'shop',
                                      address ?? usrData.address,
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
                                    print('Error');
                                    print(e.toString());
                                  }

                                } else {
                                  print('Error');
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 12.0),

                        ],
                      ),
                    ),
                  )));
          }
        else return Loading();
    });
  }
}