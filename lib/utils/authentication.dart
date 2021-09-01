import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_appdate/screens/user_info_screen.dart';

// Handles all authentication needs
class Authentication {
  // Returns instance of 'FirebaseApp'
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    // initializes Firebase
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // Checks if user is still logged in
    User? user = FirebaseAuth.instance.currentUser;
    // If they are logged in, sends you straight to UserInfoScreen
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => UserInfoScreen(user: user),
      ));
    }

    return firebaseApp;
  }

  // Authenticates login credentials and returns Google 'User' object according to given credentials
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    // Instance of Firebase Auth
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                  content:
                      "The account already exists with a different credential."));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                  content: "Error occured, invalid credentials."));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
                content: "Error occurred using Google Sign-In. Try again."));
      }
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(content: 'Error signing out. Try again.'),
      );
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}
