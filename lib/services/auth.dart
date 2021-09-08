import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';

class AuthService {
  FirebaseAuth? _auth;
  FirebaseApp? firebaseApp;
  GoogleSignIn? googleSignIn;
  GoogleSignInAccount? googleUser;

  @override
  AuthService() {
    this.initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    firebaseApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    googleSignIn = GoogleSignIn();
  }

  // Create user object based on Firebase User
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null
        ? AppUser(
            uid: user.uid,
            displayName: user.displayName ?? "No username",
            email: user.email ?? "No email",
            photoURL: user.photoURL)
        : null;
  }

  // auth change user stream
  Stream<AppUser?> get user {
    return _auth!.authStateChanges().map(_userFromFirebaseUser);
  }

  // Anonymous Sign-In
  Future<AppUser?> signInAnon() async {
    try {
      UserCredential credential = await _auth!.signInAnonymously();
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      print(err.toString());
    }
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Sign Out
  Future signOut() async {
    try {
      await googleSignIn!.signOut();
      return await _auth!.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
