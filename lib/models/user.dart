class User {
  String displayName;
  String email;
  String uid;

  User ({ required this.displayName, required this.uid, required this.email });
  
  factory User.fromMap(map) {
    return User(displayName: map["displayName"], email: map["email"], uid: map["uid"]);
  }

  getDictionary() {
    return <String, dynamic>{
      "displayName": displayName,
      "email": email,
      "uid": uid,
    }; 
  }

}
