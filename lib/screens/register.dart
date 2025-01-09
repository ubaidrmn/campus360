import 'package:campus360/services/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  late UserService userService = Get.find();

  RegisterScreen({ super.key });

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
          Padding(child: Text("Campus360 Register", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),), padding: EdgeInsets.only(bottom: 20),),
          TextField(controller: emailController, style: TextStyle(
            color: Colors.white,
          ), decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Email",
            prefixIconColor: Colors.white,
            prefixIcon: Icon(Icons.person)
          ),),
          TextField(controller: displayNameController, style: TextStyle(
            color: Colors.white,
          ), decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Display Name",
            prefixIconColor: Colors.white,
            prefixIcon: Icon(Icons.person)
          ),),
          TextField(controller: passwordController, obscureText: true, style: TextStyle(
            color: Colors.white,
          ), decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Password",
            prefixIconColor: Colors.white,
            prefixIcon: Icon(Icons.person)
          ),),
          Padding(padding: EdgeInsets.only(top: 20), child: ElevatedButton(onPressed: () async {
            try {
              await userService.register(emailController.text, passwordController.text, displayNameController.text);
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
          Padding(padding: EdgeInsets.only(top: 20), child: GestureDetector(child: Text("Already have an account? Login now", style: TextStyle(color: Colors.white),), onTap: () {
            Get.offNamed("/login");
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

