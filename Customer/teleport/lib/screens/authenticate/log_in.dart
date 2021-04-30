import 'package:flutter/material.dart';
import 'package:teleport/services/auth.dart';
import 'package:teleport/shared/constants.dart';
import 'package:teleport/shared/loading.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();

  final Function toggleView;

  LogIn({this.toggleView});

}

class _LogInState extends State<LogIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    String hexString = "39c0ba";
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color(int.parse("0xff${hexString}")),
          title: Text('Sign In'),
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: (){
                widget.toggleView();
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Enter Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Enter Password'),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 50.0,
                    width: 250.0,
                    child: RaisedButton(
                      color: Color(int.parse("0xff${hexString}")),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if(result!=null)
                            print('Success');
                          else{
                            setState(() {
                              error = 'please supply valid email';
                              loading = false;
                            });
                            print(error);
                          }

                        }else{
                          print('Error');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            )
        )
    );
  }
}
