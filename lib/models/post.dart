class Post {
  String title;
  String description;
  String path;
  String displayName;
  String uid;
  int totalLikes;
  DateTime createdAt;

  Post({required this.title, required this.description, required this.path, required this.displayName, required this.uid, required this.totalLikes, required this.createdAt});

  factory Post.fromDoc(doc) {
    var map = doc.data();

    Post post = Post(
      title: map["title"],
      description: map["description"],
      path: doc.id,
      displayName: map["displayName"],
      uid: map["uid"],
      totalLikes: map["totalLikes"],
      createdAt: map["createdAt"].toDate()
    );

    return post;
  }
}
