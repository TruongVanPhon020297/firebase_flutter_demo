import 'package:firebase_auth_example/auth_service.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(controller: emailController,),
            TextField(controller: passwordController,),
            ElevatedButton(
              onPressed: () {
                AuthService().createUserWithEmailAndPassword(emailController.value.text, passwordController.value.text);
              },
              child: const Text("Sign up"),
            ),
            ElevatedButton(
              onPressed: () {
                AuthService().signInWithEmailAndPassword(emailController.value.text, passwordController.value.text);
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                AuthService().signInWithGoogle();
              },
              child: const Text("Login with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
