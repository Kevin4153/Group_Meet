import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:group_meet/services/auth.dart';
import 'package:group_meet/services/location.dart';
import 'package:group_meet/shared/constants.dart';
import 'package:group_meet/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Future<Position> ehh = determinePosition();
 
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
              title: Text('Register to Group Meet'),
              actions: <Widget>[
                TextButton.icon(
                  style: flatButtonStyle,
                  icon: Icon(Icons.person),
                  label: Text('Sign in'),
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
                    SizedBox(height: 20.0),

                    // email
                    TextFormField(
                      decoration: textInputDeocartion.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState((() => email = val));
                      },
                    ),
                    SizedBox(height: 20.0),

                    // password
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
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error = 'please supply a valid email';
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
