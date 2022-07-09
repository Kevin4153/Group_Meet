class MyUser {
  final String? uid;

  MyUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final bool showLocation;
  final String lastLocation;

  UserData({required this.uid, required this.name, required this.showLocation, required this.lastLocation});
}
