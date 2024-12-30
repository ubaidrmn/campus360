import 'package:campus360/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxController {
  var posts = [].obs;

  fetchPosts() {
    final db = FirebaseFirestore.instance;
    db.collection("Post").snapshots().listen((snapshot) {
      posts.value = [];
      for(var doc in snapshot.docs) {
        var data = doc.data();
        this.posts.value.add(Post(title: data["title"], description: data["description"]));
      }
    });
  }

}