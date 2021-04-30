import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teleport/models/item.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/models/order.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference usrCollection = FirebaseFirestore.instance.collection('shops');

  Future<void> updateUsrData(String name, String phone, String email, String type,String address) async {
    return await usrCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'type': type,
      'address': address,
    });
  }


  Future<void> addItem(String name, double cost, String description, String shop) async {
    return await usrCollection.doc(uid).collection('items').doc().set({
      'name': name,
      'cost': cost,
      'description': description,
      'outOfStock': false,
      'shop': shop,
      'shopUID': uid,
    });
  }

  //edit Item
  Future<void> editItem(String name, double cost,
      String description, bool outOfStock, String uid) async {
    return await usrCollection.doc(this.uid).collection('items').doc(uid).set({
      'name': name,
      'cost': cost,
      "description": description,
      'outOfStock': outOfStock,
    });
  }

  // delete Item
  Future<void> deleteItem(String uid) async {
    return await usrCollection.doc(this.uid).collection('items').doc(uid).delete();
  }

  // UserData from snapshot
  UsrData _usrDataFromSnapshot(DocumentSnapshot snapshot) {
    return UsrData(
      uid: uid,
      name: snapshot.data()['name'],
      phone: snapshot.data()['phone'],
      email: snapshot.data()['email'],
      businessName: snapshot.data()['businessName'],
      address: snapshot.data()['address'],
    );
  }

  //get user doc stream
  Stream<UsrData> get usrData {
    return usrCollection.doc(uid).snapshots().map(_usrDataFromSnapshot);
  }

  //get item stream
  //FirebaseFirestore.instance.collection('shops');
  Future<Item> getItem(String uid) async {
    DocumentSnapshot snapshot = await usrCollection.doc(this.uid)
        .collection('items').doc(uid).get();

    return _itemFromSnapshot(snapshot);
  }

  //item from snapshot
  Item _itemFromSnapshot(DocumentSnapshot snapshot){
      return Item(
        name: snapshot.data()['name'] ?? '',
        cost: snapshot.data()['cost'] ?? 0.0,
        description: snapshot.data()['description'] ?? '',
        outOfStock: snapshot.data()['outOfStock'] ?? false,
        uid: snapshot.id,
        shop: snapshot.data()['shop'],
        shopUID: snapshot.data()['shopUID'],
      );

  }
  //item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    List<Item> lst = snapshot.docs.map((doc){
      return Item(
        name: doc.data()['name'] ?? '',
        cost: doc.data()['cost'] ?? 0.0,
        description: doc.data()['description'] ?? '',
        uid: doc.id,
      );
    }).toList();
    lst.sort((a, b) {
      return a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase());
    });
    return lst;
  }

  // get items stream
  Stream<List<Item>> get items {
    return usrCollection.doc(uid).collection('items').snapshots()
        .map(_itemListFromSnapshot);
  }

  List _orderListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      Map<String, dynamic> list = doc.data();
      list.remove('name');
      list.remove('uid');
      list.remove('customerUID');
      return Order(
        name: doc.data()['name'] ?? 'Anon',
        uid: doc.id,
        customerUID: doc.data()['uid'],
        list: list,
      );
    }).toList();
  }

  Stream<List<dynamic>> get activeOrders {
    return usrCollection.doc(uid).collection('active').snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<dynamic>> get processingOrders {
    return usrCollection.doc(uid).collection('processing').snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<dynamic>> get completeOrders {
    return usrCollection.doc(uid).collection('complete').snapshots()
        .map(_orderListFromSnapshot);
  }

  Future<void> acceptOrder(Order order) async {
    Map<String, dynamic> map = Map();
    order.list.forEach((key, value) { map[key] = value;});
    map['customerUID'] = order.customerUID;
    map['name'] = order.name;
    deleteOrder(order.uid);
      return await usrCollection
          .doc(this.uid)
          .collection('processing')
          .doc(order.uid)
          .set(map);
  }

  Future<void> deleteOrder(String uid) async {
    //TODO: complete this BS
    return await usrCollection.doc(this.uid).collection('active').doc(uid).delete();
  }
}