import 'package:campus360/models/post.dart';
import 'package:campus360/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxController {
  UserService userService = Get.find();
  var posts = [].obs;
  final db = FirebaseFirestore.instance;

  fetchPosts() {
    db.collection("Post").get().then((snapshot) {
      // snapshots().listen((snapshot) {})
      posts.value = [];
      for (var doc in snapshot.docs) {
        if (doc.data()["uid"] != null) {
          Post post = Post.fromDoc(doc);
          posts.add(post);
        }
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
