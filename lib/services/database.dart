import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference articleCollection =
      FirebaseFirestore.instance.collection('articles');
}
