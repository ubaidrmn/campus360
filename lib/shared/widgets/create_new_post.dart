import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateNewPost extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  publishPost() {
    final post = <String, dynamic>{
      "title": titleController.text,
      "description": descriptionController.text
    };

    db.collection("Post").add(post).then((DocumentReference doc) {
      print("${doc.id} Post Created..");
      titleController.text = "";
      descriptionController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.all(15), child: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Title"), controller: titleController,),
          TextField(decoration: InputDecoration(hintText: "Description"), controller: descriptionController,),
          ElevatedButton(onPressed: publishPost, child: Text("Publish")),
        ],
      ),),
    );
  }
}