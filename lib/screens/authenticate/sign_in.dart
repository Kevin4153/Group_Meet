import 'package:group_meet/services/auth.dart';
import 'package:group_meet/shared/constants.dart';
import 'package:group_meet/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String error = '';
  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.lightBlue[200],
              elevation: 0.0,
              title: Text('Sign in to Group Meet'),
              actions: <Widget>[
                TextButton.icon(
                  style: flatButtonStyle,
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // email
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDeocartion.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState((() => email = val));
                      },
                    ),

                    // password
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDeocartion.copyWith(hintText: 'Password'),
                      validator: (val) => val!.length < 6 ? 'Eneter a password 6+ char long' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState((() => password = val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          
                          dynamic result = _auth.signInWithEmailAndPassword(email, password);
                          setState(() => loading = true);
                          print("sssssssssss");
                          if (result == null) {
                            print("heeeeeeeeere");
                            setState(() {
                              error = 'Could not sign in with those credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
