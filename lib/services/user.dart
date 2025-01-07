import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:get/get.dart';

class UserService extends GetxController {
  var user = Rxn<fb_auth.User>();
  // final Rx<fb_auth.User?>
  // final Rx<User?> user = null.obs;

  void setupListener() {

    fb_auth.FirebaseAuth.instance
    .authStateChanges()
    .listen((fb_auth.User? _user) {
      if (user != null) {
        print("THIS IS IT");
        print(_user?.photoURL);
        user.value = _user;
      }
    });

    ever(user, (_user) {
      if (user != null) {
        Get.offAllNamed('/authenticated-screen');
      } else {
        Get.offAllNamed('/login');
      }
    });
  }

  Future<fb_auth.UserCredential> register(String email, String password) async {
    var credential = await fb_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user.value = credential.user;

    return credential;
  }

  Future<fb_auth.UserCredential> login(String email, String password) async {
    var credential = await fb_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    user.value = credential.user;

    return credential;
  }

  Future<void> logout() {
    return fb_auth.FirebaseAuth.instance.signOut();
  }

}
