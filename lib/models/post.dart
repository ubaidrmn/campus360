class Post {
  String title;
  String description;
  String path;
  String displayName;
  String uid;

  Post({required this.title, required this.description, required this.path, required this.displayName, required this.uid});

  factory Post.fromDoc(doc) {
    var map = doc.data();

    Post post = Post(
      title: map["title"],
      description: map["description"],
      path: doc.id,
      displayName: map["displayName"],
      uid: map["uid"],
    );

    return post;
  }
}
