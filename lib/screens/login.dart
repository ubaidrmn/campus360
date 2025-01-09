import 'package:campus360/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("auth_bg.jpg"),
            fit: BoxFit.cover
          ) 
        ),
        child: Padding(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,children: [
          Padding(child: Text("Campus360 Login", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),), padding: EdgeInsets.only(bottom: 20),),
          TextField(controller: emailController, style: TextStyle(
            color: Colors.white,
          ), decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Email Address",
            prefixIconColor: Colors.white,
            prefixIcon: Icon(Icons.person)
          ),),
          TextField(controller: passwordController, obscureText: true, style: TextStyle(
            color: Colors.white,
          ), decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Password",
            prefixIconColor: Colors.white,
            prefixIcon: Icon(Icons.security)
          ),),
          Padding(padding: EdgeInsets.only(top: 20), child: ElevatedButton(onPressed: () async {
            try {
              await userService.login(emailController.text, passwordController.text);
            } catch (e) {
              _dialogBuilder(context, "Error", e.toString());
            }
          }, child: Text("Login"))),
          Padding(padding: EdgeInsets.only(top: 20), child: GestureDetector(child: Text("Don't have an account? Register now", style: TextStyle(color: Colors.white)), onTap: () {
            Get.offNamed("/register");
          },),)
        ],))
      ),
    );
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