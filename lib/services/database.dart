import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // user reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // collection reference
  final CollectionReference articleCollection =
      FirebaseFirestore.instance.collection('articles');

  Future updateUserData(Map<String, int> hashtagPreferences) async {
    return await userCollection.doc(uid).set({
      'hashtagPreferences': hashtagPreferences,
    });
  }
}
