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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;

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
                  Switch(
                    value: userData.showLocation, 
                    onChanged: (val) => setState(() => _showLocation = !_showLocation!)),
                  ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _showLocation ?? userData.showLocation
                              );
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
