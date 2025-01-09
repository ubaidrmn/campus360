class Comment {
  String uid;
  String postId;
  String text;
  String displayName;

  Comment({required this.uid, required this.postId, required this.text, required this.displayName });

  factory Comment.fromDoc(map) {
    Comment comment = Comment(
      uid: map["uid"],
      postId: map["postId"],
      text: map["text"],
      displayName: map["displayName"],
    );

    return comment;
  }

}
