import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/wrapper.dart';
import 'package:teleport/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usr>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      )
    );
  }
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(),
  //       body: Center(
  //         child: SingleChildScrollView(
  //           child: Table(
  //             children: [
  //               TableRow(
  //                 children: [
  //                   Text('namelj;khglgluiiujhljkglkhjgl;kjhljk'),
  //                   Text('quantity'),
  //                   Text('Cost'),
  //                 ]
  //               ),
  //               TableRow(
  //                   children: [
  //                     Text(''),
  //                     Text(''),
  //                     Text(''),
  //                   ]
  //               ),
  //               TableRow(
  //                   children: [
  //                     Text('name'),
  //                     Text('quantity'),
  //                     Text('Cost'),
  //                   ]
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //     ),
  //   );
  // }
}
//
