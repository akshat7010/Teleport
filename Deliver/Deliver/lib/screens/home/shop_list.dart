import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {

    final shops = Provider.of<QuerySnapshot>(context);
    //print(brews.documents);
    for (var doc in shops.docs) {
      print(doc.data);
    }

    return Container(

    );
  }
}