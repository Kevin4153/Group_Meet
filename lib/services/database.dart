
import 'package:group_meet/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('User Data');

  // updates user data given the new name and new setting to show location
  // also used to create new user
  Future<void> updateUserData(String name, bool showLocation, String lastLocation) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'showLocation': showLocation, 'lastLocation': lastLocation});
  }

  Future<void> updateUserLocation(String lastLocation) async {
    
    return await userCollection
        .doc(uid)
        .set({'lastLocation': lastLocation}, SetOptions(merge: true));
  }

  // userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!,
        name: snapshot.get('name'),
        showLocation: snapshot.get('showLocation'),
        lastLocation: snapshot.get('lastLocation'));
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
