import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/item.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/root/active.dart';
import 'package:teleport/screens/home/root/complete.dart';
import 'package:teleport/screens/home/root/processing.dart';
import 'package:teleport/screens/home/root/settings.dart';
import 'package:teleport/screens/home/root/shelf.dart';
import 'package:teleport/services/auth.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/loading.dart';
String hexString = "39c0ba";
class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  final _auth = AuthService();
  bool loading = false;

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  static List<Widget> _widgetOptions = <Widget>[
    Active(),
    // Text(
    //   'Index 0',
    //   style: optionStyle,
    // ),
    Processing(),
    // Text(
    //   'Index 1: Processing',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 2: Complete',
    //   style: optionStyle,
    // ),
    Complete(),
    Shelf(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final usr = Provider.of<Usr>(context);

    return loading ? Loading() : StreamProvider<List<Item>>.value(
      value: DatabaseService(uid: usr.uid).items,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TelePort'),
          backgroundColor: Color(int.parse("0xff${hexString}")),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              icon: Icon(Icons.settings,color: Colors.black,),
            ),
            IconButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await _auth.signOut();
              },
              icon: Icon(Icons.logout,color: Colors.black,),
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.blueGrey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.star_rate),
              label: 'Active',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.donut_large),
              label: 'Processing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done_all),
              label: 'Complete',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Shelf',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
