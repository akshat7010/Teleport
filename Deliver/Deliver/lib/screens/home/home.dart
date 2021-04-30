import 'package:Deliver/screens/home/processing_tile.dart';
import 'package:Deliver/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Deliver/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Deliver/screens/home/shop_list.dart';
import 'package:Deliver/models/user.dart';
import 'package:Deliver/screens/home/Processing_list.dart';
import 'package:Deliver/models/processing.dart';
import 'package:Deliver/shared/loading.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    UserM usr = Provider.of<UserM>(context);

    return StreamProvider<QuerySnapshot>.value(
      value: DataBaseService(usr.uid).shops,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Teleport'),
            backgroundColor: Colors.blue[800],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: FutureBuilder(
            future: DataBaseService('').processingOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false)
                return Loading();
              else
                return ProcessingList(processing: snapshot.data,callBack: setState,);
            } ),
        ),
      ),
    );
  }
}