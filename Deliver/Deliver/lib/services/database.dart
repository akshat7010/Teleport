import 'package:Deliver/models/processing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Deliver/models/order.dart';


class DataBaseService{
  final String uid;
  DataBaseService(this.uid);
  final CollectionReference shopCollection = FirebaseFirestore.instance.collection('shops');

  Stream<QuerySnapshot> get shops {
    return shopCollection.snapshots();
  }
   Future <List<dynamic>> processingOrders() async  {

    var m = await FirebaseFirestore.instance
        .collectionGroup('processing')
        // .orderBy('state')
        // .startAt([0])
        // .endAt([1])
        .limit(20)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {

        return Processing(
          time: doc.data()['time'] ?? DateTime.now(),
          orderUID: doc.id,
          shopUID: doc.data()['shopUID'] ?? 'null',
          shopAddress: doc.data()['shopAddress'] ?? 'null',
          customerUID: doc.data()['customerUID'] ?? 'null',
          customerAddress: doc.data()['customerAddress'] ?? 'null',
          shopName: doc.data()['shopName'] ?? 'null',
          state: doc.data()['state'] ?? 0,
          phoneNumber: doc.data()['phoneNumber'] ?? 'null',
          cost: doc.data()['cost'] ?? -1,
        );
      });
    });
    // return [];
  return m.toList();
  }
  Future<void> selectOrder(Processing thing) async{
    //thing.state=1;
    FirebaseFirestore.instance.collection('shops').doc(thing.shopUID).collection('processing').
    doc(thing.orderUID).update({
      'state': 1,
    });
  }
  Future<void> pickOrder(Processing thing) async{
    //thing.state=1;
    FirebaseFirestore.instance.collection('shops').doc(thing.shopUID).collection('processing').
    doc(thing.orderUID).update({
      'state': 2,
    });
  }
  Future<void> deliverOrder(Processing thing) async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('shops').doc(thing.shopUID).collection('processing').
    doc(thing.orderUID).get();
    FirebaseFirestore.instance.collection('shops').doc(thing.shopUID).collection('complete').
    doc(thing.orderUID).set(snapshot.data());
    FirebaseFirestore.instance.collection('shops').doc(thing.shopUID).collection('processing').
    doc(thing.orderUID).delete();
  }
}