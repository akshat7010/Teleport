import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teleport/models/cart.dart';
import 'package:teleport/models/item.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/models/suggestion.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference usrCollection =
      FirebaseFirestore.instance.collection('customers');

  Future updateUsrData(String name, String phone, String email) async {
    return await usrCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  Future<void> addItem(
      String name, double cost, String description, String shop) async {
    return await usrCollection.doc(uid).collection('items').doc().set({
      'name': name,
      'cost': cost,
      'description': description,
      'out_of_stock': false,
      'shop': shop,
      'shopUID': uid,
    });
  }

  //edit Item
  Future<void> editItem(String name, double cost, String description,
      bool outOfStock, String uid) async {
    return await usrCollection.doc(this.uid).collection('items').doc(uid).set({
      'name': name,
      'cost': cost,
      "description": description,
      'outOfStock': outOfStock,
    });
  }

  // delete Item
  Future<void> deleteItem(String uid) async {
    return await usrCollection
        .doc(this.uid)
        .collection('items')
        .doc(uid)
        .delete();
  }

  // UserData from snapshot
  UsrData _usrDataFromSnapshot(DocumentSnapshot snapshot) {
    return UsrData(
      uid: uid,
      name: snapshot.data()['name'],
      phone: snapshot.data()['phone'],
      email: snapshot.data()['email'],
      businessName: snapshot.data()['businessName'],
      address: snapshot.data()['address']??'null',
    );
  }

  //get user doc stream
  Stream<UsrData> get usrData {
    return usrCollection.doc(uid).snapshots().map(_usrDataFromSnapshot);
  }

  //item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    List<Item> lst = snapshot.docs.map((doc) {
      return Item(
        name: doc.data()['name'] ?? '',
        cost: doc.data()['cost'] ?? 0.0,
        description: doc.data()['description'] ?? '',
        uid: doc.id,
        shopUID: doc.data()['shopUID'] ?? '',
        shop: doc.data()['shop'] ?? '',
        outOfStock: doc.data()['outOfStock'] ?? false,
      );
    }).toList();
    lst.sort((a, b) {
      return a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase());
    });
    return lst;
  }

  // get items stream
  Stream<List<Item>> get items {
    return usrCollection
        .doc(uid)
        .collection('items')
        .snapshots()
        .map(_itemListFromSnapshot);
  }

  Future<List<Item>> getItems() async {
    try {
      var l = await FirebaseFirestore.instance
          .collection('shops')
          .doc(uid)
          .collection('items')
          .orderBy('name')
          .startAt([''])
          .get()
          .then((snapshot) {
            return snapshot.docs.map((doc) {
              return Item(
                name: doc.data()['name'],
                cost: doc.data()['cost'] ?? 0.0,
                description: doc.data()['description'] ?? '',
                uid: doc.id,
                shopUID: doc.data()['shopUID'] ?? '',
                shop: doc.data()['shop'] ?? '',
                outOfStock: doc.data()['outOfStock'] ?? false,
              );
            });
          });

      return l.toList();
    } on Exception catch (e) {
      print('hey error');
      print(e.toString());
      return [];
    }
  }

  Future<List<Suggestion>> getSuggestion(String searchKey) async {
    try {
      searchKey = searchKey.toLowerCase();
      var l = await FirebaseFirestore.instance
          .collection('shops')
          .orderBy('searchKey')
          .startAt([searchKey])
          .endAt([searchKey + '\uf8ff'])
          .limit(5)
          .get()
          .then((snapshot) {
            return snapshot.docs.map((doc) {
              return Suggestion(
                uid: doc.id,
                shopUID: "",
                title: doc.data()['businessName'],
                subtitle: doc.data()['email'],
                type: 'shop',
                shop: UsrData(
                  uid: doc.id,
                  name: doc.data()['name'],
                  phone: doc.data()['phone'],
                  email: doc.data()['email'],
                  businessName: doc.data()['businessName'],
                  address: doc.data()['address']??'null',
                ),
              );
            });
          });
      var m = await FirebaseFirestore.instance
          .collectionGroup('items')
          .orderBy('name')
          .startAt([searchKey])
          .endAt([searchKey + '\uf8ff'])
          .limit(5)
          .get()
          .then((snapshot) {
            return snapshot.docs.map((doc) {
              return Suggestion(
                uid: doc.id,
                shopUID: doc.data()['shopUID'],
                title: doc.data()['name'],
                item: Item(
                  name: doc.data()['name'],
                  cost: doc.data()['cost'] ?? 0.0,
                  description: doc.data()['description'] ?? '',
                  uid: doc.id,
                  shopUID: doc.data()['shopUID'] ?? '',
                  shop: doc.data()['shop'] ?? '',
                  outOfStock: doc.data()['outOfStock'] ?? false,
                ),
                subtitle: 'by ${doc.data()['shop'].toString()}',
                type: 'item',
              );
            });
          });
      return l.toList() + m.toList();
    } on Exception catch (e) {
      print('hey error');
      print(e.toString());
      return [];
    }
  }

  Future<void> addCart(Cart cart) async {
    cart.list.addAll({
      'shop': cart.shop,
    });
    return await usrCollection
        .doc(uid)
        .collection('cart')
        .doc(cart.shopUID)
        .set(cart.list);
  }

  Future<void> addOrder(Cart cart) async {
    Map<String, dynamic> map = Map();
    cart.list.forEach((key, value) { if(value.value>0) map[key] = value.value;});
    await getName(cart.uid)
    .then((name) async {
      map.addAll({
        'name': name,
        'time': DateTime.now(),
        'shopUID': cart.shopUID,
        'shopAddress': cart.shopAddress,
        'customerUID': cart.uid,
        'customerAddress': cart.customerAddress,
        'phoneNumber': cart.phone,
        'shopName': cart.shopName,
        'state': 0,
        'cost': cart.cost,
        //here add the other fields as said by boss
      });
      return await FirebaseFirestore.instance.collection('shops')
          .doc(cart.shopUID)
          .collection('active')
          .doc()
          .set(map);
    });

  }

  Future<String> getName(String uid) async {
    return await usrCollection
        .doc(uid)
        .get()
        .then((snapshot){
          if(snapshot.data()!=null)
            return snapshot.data()['name'];
          else return "";
    });
  }
  Future<Cart> findCart(String shopUID) async {
    try{
      return await usrCollection
          .doc(uid)
          .collection('cart')
          .doc(shopUID)
          .get()
          .then((snapshot) {
        if(snapshot.data()==null) {
          Map<String,dynamic> list = Map();
          return Cart(
            shop: null,
            shopUID: shopUID,
            list: list,
          );
        }
        Map<String, dynamic> list = snapshot.data();
        String shop;
        print('h:${shopUID[0]}');
        print(uid);
        print(snapshot.data());
        list.forEach((key, value) {print("$key: $value");});
        shop = list['shop'];
        list.remove('shop');

        print("duck3");
        return Cart(
          shop: shop,
          shopUID: shopUID,
          list: list,
        );
      });
    }catch(e){
      print("f${e.toString()}f");
      return null;
    }
  }

  Future<int> findQuantityInCart(String shopUID, String itemUID) async {
    try{
      return await usrCollection
          .doc(uid)
          .collection('cart')
          .doc(shopUID)
          .get()
          .then((snapshot) {
        print('h:${shopUID[0]}');
        if (snapshot.data().containsKey(itemUID))
          return snapshot.data()[itemUID];
        else
          return 0;
      });
    }catch(e){
      print('HHH');
      print(e.toString());
      return 0;
    }
  }
}
