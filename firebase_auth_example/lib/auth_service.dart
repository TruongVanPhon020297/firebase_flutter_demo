import 'package:firebase_auth_example/verify.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_page.dart';
import 'login_page.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.emailVerified == true) {
          return const HomePage();
        } else if (snapshot.hasData && snapshot.data!.emailVerified == false) {
          return const Verify();
        }
        else {
          return const LoginPage();
        }
      },
    );
  }

  signInWithGoogle() async {
    // final GoogleSignInAccount? googleUser =
    //     await GoogleSignIn(scopes: <String>['email']).signIn();
    //
    // final GoogleSignInAuthentication googleAuth =
    //     await googleUser!.authentication;
    //
    // final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    //
    // return await FirebaseAuth.instance.signInWithCredential(credential);









    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);



  }

  Future<void> signOut() async {
    // GoogleSignIn googleSignIn = GoogleSignIn();
    // if (googleSignIn.currentUser != null) {
    //   await googleSignIn.disconnect();
    // }
    // await FirebaseAuth.instance.signOut();


    final GoogleSignIn googleSignIn = GoogleSignIn();

    if(googleSignIn.currentUser != null) {
      await googleSignIn.disconnect();
    }

    await FirebaseAuth.instance.signOut();


  }


  createUserWithEmailAndPassword(String email, String password) async {
    // try {
    //   final credential =
    //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   User? user = FirebaseAuth.instance.currentUser;
    //   if (user != null && !user.emailVerified) {
    //     await FirebaseAuth.instance.setLanguageCode("vi");
    //     await user.sendEmailVerification();
    //
    //   }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }


    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      User? user = FirebaseAuth.instance.currentUser;

      if(user != null && !user.emailVerified){
        await FirebaseAuth.instance.setLanguageCode("vi");
        await user.sendEmailVerification();
        await user.updateDisplayName("Trương Văn Phôn");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }

  signInWithEmailAndPassword(String email, String password) async {
    try {
      // final credential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
