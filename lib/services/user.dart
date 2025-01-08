import 'dart:collection';

import 'package:campus360/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:get/get.dart';

class UserService extends GetxController {
  var firebaseUser = Rxn<fb_auth.User>();
  var user = Rxn<User>();

  final db = FirebaseFirestore.instance;

  void setupListener() {

    fb_auth.FirebaseAuth.instance
    .authStateChanges()
    .listen((fb_auth.User? authenticatedFirebaseUser) {

      if (authenticatedFirebaseUser != null) {
        firebaseUser.value = authenticatedFirebaseUser;
        db.collection("User").where("uid", isEqualTo: authenticatedFirebaseUser.uid).get().then((value) {
          var userData = value.docs[0].data();
          user.value = User.fromMap(userData);
          Get.offAllNamed('/authenticated-screen');
        });
      } else {
        Get.offAllNamed('/login');
      }

    });
  }

  Future<fb_auth.UserCredential> register(String email, String password, String displayName) async {
    var credential = await fb_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user?.uid != null) {
      user.value = User(displayName: displayName, email: email, uid: credential.user!.uid);
      var userData = user.value?.getDictionary();
      await db.collection("User").add(userData);
      firebaseUser.value = credential.user;
      Get.offNamed("/authenticated-screen");
    }

    return credential;
  }

  Future<fb_auth.UserCredential> login(String email, String password) async {
    var credential = await fb_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential;
  }

  Future<void> logout() {
    return fb_auth.FirebaseAuth.instance.signOut();
  }

}
