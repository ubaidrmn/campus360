import 'package:campus360/models/post.dart';
import 'package:campus360/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommentService extends GetxController {
  final db = FirebaseFirestore.instance;

  Future fetchCommentsForPost(docPath) {
    return db.collection("Comment").where("postId", isEqualTo: docPath).get();
  }
}
