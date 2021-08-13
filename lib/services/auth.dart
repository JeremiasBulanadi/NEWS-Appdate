import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_appdate/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // anonymous sign in
  Future anonSignIn() async {
    try {
      UserCredential userCred = await _auth.signInAnonymously();
      User? user = userCred.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // email & password sign in

  // email & password registration

  // sign out

}
