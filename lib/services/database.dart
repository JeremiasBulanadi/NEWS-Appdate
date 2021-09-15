import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/aylien_data.dart';
import 'dart:convert';
import 'dart:async';

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

    bool isSaved = await userSaveJson['savedStories'].contains(storyId);
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

    // This is so that the the more recent saves are the ones on top
    stories = new List.from(stories.reversed);

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

  // This is for managing hashtags
  Future<void> hashtagCount(String? uid, List<String> storyHashtags) async {
    DocumentSnapshot<Object?> user = await userCollection.doc(uid).get();
    Map<String, dynamic> userJson = user.data() as Map<String, dynamic>;
    Map<String, dynamic> userPreferences = {};
    print("this is userJson");
    print(userJson);

    userPreferences = Map.from(await userJson['hashtagPreferences']);
    print("this is userPreferences");
    print(userPreferences);

    for (String hashtag in storyHashtags) {
      if (userPreferences.containsKey(hashtag)) {
        userPreferences[hashtag] += 5;
      } else {
        userPreferences[hashtag] = 5;
      }
    }
    print(userPreferences);
    userPreferences.forEach((key, value) {
      userPreferences[key] = userPreferences[key] - 1;
    });

    print("USER PREFERENCES BEFORE: $userPreferences");
    // If you're wondering what the ".." means, its called the cascade notation in dart
    userPreferences = Map.from(userPreferences)
      ..removeWhere((key, value) => value <= 0);
    print("USER PREFERENCES NOW: $userPreferences");

    print(userPreferences);

    // TODO: Continue hashtag preferences

    // if (await userJson['hashtagPreferences'] != null) {
    //   userPreferences = await json
    //           .decode(json.encode(userJson['hashtagPreferences'].toString())) ??
    //       [];
    // }

    // print("this is user preferences");
    // print(userPreferences);
  }
}
