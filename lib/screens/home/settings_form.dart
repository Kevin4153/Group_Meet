import 'package:geolocator/geolocator.dart';
import 'package:group_meet/models/user.dart';
import 'package:group_meet/services/database.dart';
import 'package:group_meet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:group_meet/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String? _currentName;
  bool? _showLocation;
  Position? _lastPosition = null;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            _showLocation ??= userData.showLocation;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDeocartion,
                    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Show Location'),
                      Switch(
                          value: _showLocation!,
                          onChanged: (val) => setState(() => _showLocation = !_showLocation!)),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name, _showLocation!, userData.lastLocation);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
