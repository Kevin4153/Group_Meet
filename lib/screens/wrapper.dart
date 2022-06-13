import 'package:group_meet/models/user.dart';
import 'package:group_meet/screens/authenticate/authenticate.dart';
//import 'package:group_meet/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:group_meet/shared/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    // accessing user data every time we get a new value from the StreamProvider in main
    final user = Provider.of<MyUser?>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Loading();
    }
  }
}
