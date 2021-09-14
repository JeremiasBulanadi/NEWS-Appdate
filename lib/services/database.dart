import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/aylien_data.dart';
import 'dart:convert';
import 'dart:async';

// TODO: Fix saving

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // user reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // collection reference
  final CollectionReference storiesCollection =
      FirebaseFirestore.instance.collection('stories');

  Future updateUserData(
      Map<String, int> hashtagPreferences, List<String> savedStories) async {
    return await userCollection.doc(uid).set({
      'hashtagPreferences': hashtagPreferences,
      'savedStories': savedStories,
    });
  }

  // List<Story> _getStoryFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     //return Story()
  //   });
  // }

  Future<void> saveStory(String? uid, Story story) async {
    var storyJson = story.toJson();
    storyJson["created"] = Timestamp.now();

    if (uid != null) {
      await userCollection
          .doc(uid)
          .update({
            "savedStories": FieldValue.arrayUnion([story.id.toString()])
          })
          .then((value) => print(
              "${story.id} has been succesfully added to saved stories of user $uid"))
          .catchError((err) => print(err.toString()));

      return await storiesCollection
          .doc(story.id.toString())
          .set(story.toJson())
          .then((val) => print("Story added: ${story.id}"))
          .catchError((err) => print(err.toString()));
    }
  }

  Future<void> unsaveStory(String? uid, Story story) async {
    var storyJson = story.toJson();
    storyJson["created"] = Timestamp.now();

    if (uid != null) {
      await userCollection
          .doc(uid)
          .update({
            "savedStories": FieldValue.arrayRemove([story.id.toString()])
          })
          .then((value) => print(
              "${story.id} has been succesfully removed from saved stories of user $uid"))
          .catchError((err) => print(err.toString()));
    }
  }

  // get user info stream
  Future<DocumentReference> get userData async {
    return userCollection.doc(uid);
  }

  Future<bool> isStorySaved(String? uid, String storyId) async {
    DocumentSnapshot<Object?> user = await userCollection.doc(uid).get();
    Map<String, dynamic> userSaveJson = user.data() as Map<String, dynamic>;
    print(userSaveJson);

    bool isSaved = userSaveJson['savedStories'].contains(storyId);
    print("Is it saved? well that is $isSaved");
    return isSaved;
  }

  Future<List<Story>?> savedStoriesOfUser(String uid) async {
    DocumentSnapshot<Object?> user = await userCollection.doc(uid).get();
    Map<String, dynamic> userSaveJson = user.data() as Map<String, dynamic>;
    print(userSaveJson);
    //storyIds.addAll(); // This thing stops code flow for some reason

    List<Story> stories = [];

    for (String id in userSaveJson['savedStories']) {
      await storiesCollection.doc(id).get().then((value) {
        Story story;
        Map<String, dynamic> storyJson = value.data() as Map<String, dynamic>;
        story = Story.fromJson(storyJson);
        stories.add(story);
      });
    }

    return stories;
  }

  Future<bool> checkIfStoryInDatabase(String storyId) async {
    try {
      var doc = await storiesCollection.doc(storyId).get();
      return doc.exists;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<bool> checkIfUserInDatabase(String? uid) async {
    try {
      var doc = await userCollection.doc(uid).get();
      return doc.exists;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
