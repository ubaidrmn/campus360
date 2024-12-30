import 'package:campus360/services/user.dart';
import 'package:campus360/shared/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(title: "Login", child: Padding(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,children: [
          TextField(controller: emailController, decoration: InputDecoration(
            hintText: "Email"
          ),),
          TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(
            hintText: "Password",
          ),),
          Padding(padding: EdgeInsets.only(top: 10), child: ElevatedButton(onPressed: () async {
            try {
              await userService.login(emailController.text, passwordController.text);
              Get.offNamed("/feed");
            } catch (e) {
              _dialogBuilder(context, "Error", e.toString());
            }
          }, child: Text("Login"))),
          Padding(padding: EdgeInsets.only(top: 10), child: GestureDetector(child: Text("Don't have an account? Register now"), onTap: () {
            Get.offNamed("/register");
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