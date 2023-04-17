
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_example/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            children: [
              Text(FirebaseAuth.instance.currentUser!.displayName!),
              ElevatedButton(onPressed: () async {
                await AuthService().signOut();
              }, child: const Text("Sign out"))
            ],
          ),
        ),
      ),
    );
  }
}
