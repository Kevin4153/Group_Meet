import 'package:geolocator/geolocator.dart';
import 'package:group_meet/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:group_meet/shared/constants.dart';



class Warnings extends StatefulWidget {
  const Warnings({Key? key, required }) : super(key: key);

  @override
  State<Warnings> createState() => _WarningsState(); 
}

class _WarningsState extends State<Warnings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Group Meet'),
        backgroundColor: Colors.lightBlue[200],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('logout')),
        ],
      ),
      body: Center(
        
        child:  Column(
          
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget> [
            SizedBox(height: 30.0,),
            Text(
            "Location services must be enabled to properly use app",
            
            ),

            ElevatedButton(
              style: raisedButtonStyle,
              child: Text("Open Location Settings"),
              onPressed: () {
                Geolocator.openAppSettings();
              },
            ),
           
          ]
        ),
      ),
    );
  }
}
