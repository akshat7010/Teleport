import 'package:firebase_auth/firebase_auth.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/services/database.dart';

class AuthService{

  final _auth = FirebaseAuth.instance;

  // user modeling
  Usr _usrFromUser(User user) {
    return user==null ? null : Usr(uid: user.uid);
  }

  // auth change user stream
  Stream<Usr> get user {
    // print(_auth.authStateChanges());
    return _auth.authStateChanges().map(_usrFromUser);
  }

  // sign in email ID
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _usrFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register email ID
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUsrData('Name', 'phone', email);
      // create a new document for the user with the uid
      return _usrFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}