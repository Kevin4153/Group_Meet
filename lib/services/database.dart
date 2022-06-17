import 'package:geolocator/geolocator.dart';
import 'package:group_meet/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('User Data');

  // updates user data given the new name and new setting to show location
  Future<void> updateUserData(String name, bool showLocation) async {
    return await userCollection.doc(uid).set({'name': name, 'showLocation': showLocation});
  }

  // updates user lastLocation 
  Future<void> updateUserLastLocation(Position lastLocation) async {
    return await userCollection.doc(uid).set({'lastLocation': lastLocation});
  }

  Future<void> newUserData(String name, bool showLocation, Position? lastLocation) async {
    return await userCollection.doc(uid).set({'name': name, 'showLocation': showLocation, 'lastLocation' : lastLocation});
  }

  // creates new user 


  // userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!, name: snapshot.get('name'), showLocation: snapshot.get('showLocation'));
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
