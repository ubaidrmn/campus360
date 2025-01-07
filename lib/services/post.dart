import 'package:campus360/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxController {
  var posts = [].obs;
  final db = FirebaseFirestore.instance;

  fetchPosts() {
    db.collection("Post").snapshots().listen((snapshot) {
      posts.value = [];
      for (var doc in snapshot.docs) {
        var data = doc.data();
        posts.add(Post(
            title: data["title"],
            description: data["description"],
            path: doc.id));
      }
    });
  }

  deletePost(String docPath) {
    db.collection("Post").doc(docPath).delete();
  }

  editPost(String docPath, Post nPostewPost) {
    // data = db.collection("Post").doc(docPath).update(data);
  }
}
