import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/aylien_data.dart';
import 'dart:async';
import 'dart:collection';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // user reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // collection reference
  final CollectionReference storiesCollection =
      FirebaseFirestore.instance.collection('stories');

  Future createUserData(String? uid) async {
    if (uid != null) {
      return await userCollection.doc(uid).set({
        'hashtagPreferences': {},
        'savedStories': [],
      });
    }
  }

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
      var doc = userCollection.doc(uid).get();
      //if (await doc.get())

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
    List<int> userSaves = [];
    userSaveJson['savedStories']
        .forEach((val) => userSaves.add(int.parse(val)));
    print("This is our user saves:");
    print(userSaves);
    //storyIds.addAll(); // This thing stops code flow for some reason

    List<Story> stories = [];

    await storiesCollection.where("id", whereIn: userSaves).get().then((value) {
      var values = value.docs.map((element) => element.data()).toList();
      print(values);
      var example = Story.fromJson(values[0] as Map<String, dynamic>);
      print(example);
      print("ya");
      stories = values
          .map((story) => Story.fromJson(story as Map<String, dynamic>))
          .toList();
      print("be");
      print(stories.length);

      print("The saved stories ready to be returned are ");
      print(stories);
      // This is so that the the more recent saves are the ones on top
    });

    // Story story = Story.fromJson(element.data() as Map<String, dynamic>);
    // stories.add(story);

    // print(userSaveJson['savedStories']);
    // for (String id in await userSaveJson['savedStories']) {
    //   await storiesCollection.doc(id).get().then((DocumentSnapshot value) {
    //     //Story story;
    //     if (value.exists) {
    //       Map<String, dynamic> storyJson = value.data() as Map<String, dynamic>;
    //       storyJson.forEach((key, value) {
    //         print(key);
    //       });
    //       //print(storyJson);
    //       print(1);
    //       stories.add(Story.fromJson(storyJson));
    //     } else {
    //       print("Value does not exist");
    //     }
    //   });
    // }
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
    Map<String, dynamic> userPreferences = userJson['hashtagPreferences'] ?? {};
    print("this is userJson");
    print(userJson);

    userPreferences = Map.from(await userJson['hashtagPreferences']);
    // print("this is userPreferences");
    // print(userPreferences);

    for (String hashtag in storyHashtags) {
      if (userPreferences.containsKey(hashtag)) {
        userPreferences[hashtag] += 5;
      } else {
        userPreferences[hashtag] = 5;
      }
    }
    // print(userPreferences);
    userPreferences.forEach((key, value) {
      userPreferences[key] = userPreferences[key] - 2;
    });

    // print("USER PREFERENCES BEFORE: $userPreferences");
    // If you're wondering what the ".." means, its called the cascade notation in dart
    userPreferences = Map.from(userPreferences)
      ..removeWhere((key, value) => value <= 0);
    // print("USER PREFERENCES NOW: $userPreferences");

    print(userPreferences);

    await userCollection
        .doc(uid)
        .update({"hashtagPreferences": userPreferences});

    // if (await userJson['hashtagPreferences'] != null) {
    //   userPreferences = await json
    //           .decode(json.encode(userJson['hashtagPreferences'].toString())) ??
    //       [];
    // }

    // print("this is user preferences");
    // print(userPreferences);
  }

  Future<LinkedHashMap<String, int>> getTopPreferences(String uid) async {
    LinkedHashMap<String, int> topPreferences =
        new LinkedHashMap<String, int>();

    DocumentSnapshot<Object?> user = await userCollection.doc(uid).get();
    Map<String, dynamic> userJson = user.data() as Map<String, dynamic>;
    Map<String, dynamic> userPreferences = userJson['hashtagPreferences'] ?? {};

    List<dynamic> sortedKeys = userPreferences.keys.toList(growable: false)
      ..sort((k1, k2) => userPreferences[k2].compareTo(userPreferences[k1]));

    print(sortedKeys);

    LinkedHashMap<String, int> sortedMap = new LinkedHashMap.fromIterable(
        sortedKeys.take(10),
        key: (k) => k,
        value: (k) => userPreferences[k]);
    print(sortedMap);

    topPreferences = sortedMap;

    return topPreferences;
  }

  Future<LinkedHashMap<String, int>> getPreferences(String uid) async {
    LinkedHashMap<String, int> preferences = new LinkedHashMap<String, int>();

    DocumentSnapshot<Object?> user = await userCollection.doc(uid).get();
    Map<String, dynamic> userJson = user.data() as Map<String, dynamic>;
    Map<String, dynamic> userPreferences = userJson['hashtagPreferences'] ?? {};

    List<dynamic> sortedKeys = userPreferences.keys.toList(growable: false)
      ..sort((k1, k2) => userPreferences[k2].compareTo(userPreferences[k1]));

    print(sortedKeys);

    LinkedHashMap<String, int> sortedMap = new LinkedHashMap.fromIterable(
        sortedKeys,
        key: (k) => k,
        value: (k) => userPreferences[k]);
    print(sortedMap);

    preferences = sortedMap;

    return preferences;
  }
}
