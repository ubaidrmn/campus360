import 'package:campus360/services/user.dart';
import 'package:campus360/shared/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late UserService userService = Get.find();

  RegisterScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(title: "Register An Account", child: Padding(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,children: [
          TextField(controller: emailController, decoration: InputDecoration(
            hintText: "Email"
          ),),
          TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(
            hintText: "Password",
          ),),
          Padding(padding: EdgeInsets.only(top: 10), child: ElevatedButton(onPressed: () async {
            try {
              await userService.register(emailController.text, passwordController.text);
              Get.offNamed("/feed");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                _dialogBuilder(context, "Error", "The password provided is too weak");
              } else if (e.code == 'email-already-in-use') {
                _dialogBuilder(context, "Error", "The account already exists for that email");
              }
            } catch (e) {
              _dialogBuilder(context, "Error", e.toString());
            }
          }, child: Text("Register"))),
          Padding(padding: EdgeInsets.only(top: 10), child: GestureDetector(child: Text("Already have an account? Login now"), onTap: () {
            Navigator.pushNamed(context, "/login");
          },),)
        ],)));
  }

  Future<void> _dialogBuilder(BuildContext context, String title, String text) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Try again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

