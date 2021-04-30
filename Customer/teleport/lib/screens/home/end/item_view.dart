// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:teleport/models/item.dart';
// import 'package:teleport/models/user.dart';
// import 'package:teleport/screens/home/end/counter_view.dart';
// import 'package:teleport/services/database.dart';
//
// class ItemView extends StatefulWidget {
//   final Item item;
//   ItemView({this.item});
//
//   @override
//   _ItemViewState createState() => _ItemViewState();
// }
//
// class _ItemViewState extends State<ItemView> {
//   @override
//   Widget build(BuildContext context) {
//     Usr usr = Provider.of<Usr>(context);
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text(widget.item.name),
//         backgroundColor: Colors.blueAccent[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20.0),
//                 child: Image.asset('assets/ps5.png'),
//               ),
//             ),
//             Divider(
//               color: Colors.grey[800],
//               height: 60.0,
//             ),
//             Text(
//               'provided by ${widget.item.shop}',
//               style: TextStyle(
//                 color: Colors.grey,
//                 letterSpacing: 2.0,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.item.cost.toString(),
//                   style: TextStyle(
//                     color: Colors.amberAccent[200],
//                     fontWeight: FontWeight.bold,
//                     fontSize: 28.0,
//                     letterSpacing: 2.0,
//                   ),
//                 ),
//                 SizedBox(
//                     height: 30.0,
//                     width: 96.0,
//                     child: FutureBuilder(
//                         future: DatabaseService(uid: usr.uid)
//                             .findQuantityInCart(
//                                 widget.item.shopUID, widget.item.uid),
//                         builder: (context, snapshot) {
//
//                           if (snapshot.hasData) {
//                             print(snapshot.data);
//                             return CounterView(
//                               itemUID: widget.item.uid,
//                               shopUID: widget.item.shopUID,
//                               shop: widget.item.shop,
//                               initNumber: snapshot.data,
//                             );
//                           } else
//                             return Center(
//                               child: SpinKitWanderingCubes(
//                                 color: Colors.blueAccent[700],
//                                 size: 30.0,
//                               ),
//                             );
//                         })),
//               ],
//             ),
//             SizedBox(height: 30.0),
//             Text(
//               'Description',
//               style: TextStyle(
//                 color: Colors.grey,
//                 letterSpacing: 2.0,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               widget.item.description,
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 20.0,
//                 letterSpacing: 2.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
