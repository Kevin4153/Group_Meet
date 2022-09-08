import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:group_meet/models/user.dart';
import 'package:group_meet/screens/authenticate/authenticate.dart';
//import 'package:group_meet/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:group_meet/screens/home/home.dart';
import 'package:group_meet/screens/locationWarning.dart';
import 'package:group_meet/shared/loading.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = true;
  LocationPermission? permission;

  // function to change permission and show different screen
  changePermission(checkedPermission) {
    setState(() => permission = checkedPermission);
  }

  Widget build(BuildContext context) {
    // accessing user data every time we get a new value from the StreamProvider in main
    final user = Provider.of<MyUser?>(context);

    bool checkAgain = false;
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      _checkServiesPermission();

      if (loading) {
        return Loading();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == null) {
        return Warnings(changePermission: changePermission);
      } else {
        return Home();
      }
    }
  }

  _checkServiesPermission() async {
    bool serviceEnabled;
  

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    

    setState(() {
      loading = false;
    });
  }
}
