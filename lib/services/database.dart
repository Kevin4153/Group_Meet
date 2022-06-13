import 'package:group_meet/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_meet/models/user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String name, bool showLocation) async {
    return await brewCollection.doc(uid).set({'name': name, 'showLocation': showLocation});
  }

 

  // userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid!, 
    name: snapshot.get('name'),
    showLocation: snapshot.get('showLocation'));
  }


  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
