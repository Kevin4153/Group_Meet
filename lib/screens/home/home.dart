import 'package:group_meet/screens/home/settings_form.dart';
import 'package:group_meet/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:group_meet/services/database.dart';
import 'package:group_meet/shared/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return Loading();
  }
}
