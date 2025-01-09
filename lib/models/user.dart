class User {
  String displayName;
  String email;
  String uid;
  List<dynamic> likedPosts;

  User ({ required this.displayName, required this.uid, required this.email, required this.likedPosts });
  
  factory User.fromMap(map) {
    return User(displayName: map["displayName"], email: map["email"], uid: map["uid"], likedPosts: map["likedPosts"]);
  }

  getDictionary() {
    return <String, dynamic>{
      "displayName": displayName,
      "email": email,
      "uid": uid,
      "likedPosts": likedPosts
    }; 
  }

}
