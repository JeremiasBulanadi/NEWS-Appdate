class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;
  List<String> savedNewsID = [];
  Map<String, int> hashtagPreference = {};

  AppUser(
      {required this.uid,
      required this.displayName,
      required this.email,
      required this.photoURL});

  void plusPreference(String hashtag) {
    hashtagPreference.putIfAbsent(hashtag, () => 0);
    hashtagPreference.update(hashtag, (val) => val + 5);

    hashtagPreference.forEach((key, value) {
      hashtagPreference[key] = value - 1;
      //if (hashtagPreference[key] < 1)
    });
  }
}
