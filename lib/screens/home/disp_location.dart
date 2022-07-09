import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:group_meet/services/database.dart';
import 'package:group_meet/shared/constants.dart';

class DispLocation extends StatefulWidget {
  const DispLocation({Key? key}) : super(key: key);

  @override
  State<DispLocation> createState() => _DispLocationState();
}

class _DispLocationState extends State<DispLocation> {
  Position? _currentPosition;
  String? _currentAddress;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
        stream: Geolocator.getPositionStream(
            locationSettings:
                LocationSettings(accuracy: LocationAccuracy.best)),
        builder: (context, snapshot) {
          _currentPosition = snapshot.data;
          _getContAddress();
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //if (_currentAddress != null) Text(_currentAddress!),
                Text(snapshot.data.toString()),
                if (_currentAddress != null) Text(_currentAddress!),
                ElevatedButton(
                  style: raisedButtonStyle,
                  child: Text("Get Location"),
                  onPressed: () {
                    print(_currentAddress);

                    _checkServiesPermission();

                    _getCurrentLocation();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      print(placemarks);
      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";

        // need to an UID in DatabaseService paramater
        // creats a new user everytime
        DatabaseService ds = DatabaseService();
        ds.updateUserLocation(place.street!);
      });
    } catch (e) {
      print(e);
    }
  }

  _getContAddress() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {_currentAddress = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";});
      
    } catch (e) {
      print(e);
    }
  }

  _checkServiesPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
