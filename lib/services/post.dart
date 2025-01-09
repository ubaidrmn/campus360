import 'package:campus360/models/post.dart';
import 'package:campus360/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxController {
  UserService userService = Get.find();
  var posts = [].obs;
  var postsLikedByUser = [].obs;
  final db = FirebaseFirestore.instance;

  fetchPosts() {
    db.collection("UserPostLike").where("uid", isEqualTo: userService.user.value?.uid).get().then((snapshot) {
      postsLikedByUser.value = [];
      for (var doc in snapshot.docs) {
        postsLikedByUser.add(doc.data()["postId"]);
      }
    });

    db.collection("Post").snapshots().listen((snapshot) {
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

  handlePostLikeClick(String docPath) async {
    if (userService.user.value?.likedPosts.contains(docPath) == true) {
      print("FOUND LIKE");
      var newLikedPosts = userService.user.value!.likedPosts;
      newLikedPosts.remove(docPath);
      await userService.updateLikedPosts(newLikedPosts);
      await db.collection("Post").doc(docPath).update({
        "totalLikes": FieldValue.increment(-1),
      });
    } else {
      print("FOUND NO LIKE");
      print([...userService.user.value!.likedPosts, docPath]);
      await userService.updateLikedPosts([...userService.user.value!.likedPosts, docPath]);
      await db.collection("Post").doc(docPath).update({
        "totalLikes": FieldValue.increment(1),
      });
    }
  }
}
