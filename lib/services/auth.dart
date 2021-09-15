import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/database.dart';
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

  // auth change user stream
  Stream<AppUser?> get user {
    return _auth!.authStateChanges().map(_userFromFirebaseUser);
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

  // Anonymous Sign-In
  Future<AppUser?> signInAnon() async {
    try {
      UserCredential credential = await _auth!.signInAnonymously();
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Sign in with Google
  Future<AppUser?> signInWithGoogle() async {
    try {
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

      // Signs in with the third party credentials
      UserCredential userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCred.user;

      AppUser? appUser = _userFromFirebaseUser(user);

      await DatabaseService().createUserData(appUser?.uid);

      return appUser;
    } catch (err) {
      print(err.toString());
      return null;
    }
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
