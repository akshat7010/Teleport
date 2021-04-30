import 'package:flutter/material.dart';
import 'package:teleport/screens/home/end/find.dart';
import 'package:teleport/services/auth.dart';

class End extends StatefulWidget {
  @override
  _EndState createState() => _EndState();
}

class _EndState extends State<End> {
  final _auth = AuthService();

  Widget body = End();

  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Find(),
    Text(
      'Index 1: Cart',
      style: optionStyle,
    ),
    Text(
      'Index 2: Orders',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String hexString = "39c0ba";
    return Scaffold(
      appBar: AppBar(
        title: Text('TelePort'),
        backgroundColor: Color(int.parse("0xff${hexString}")),
        elevation: 0.0,
        actions: [
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.logout),
            label: Text(''),
          )
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
            icon: Icon(Icons.search),
            label: 'Find',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
