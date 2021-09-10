class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;
  late Map<String, int> hashtagPreference;

  AppUser(
      {required this.uid,
      required this.displayName,
      required this.email,
      required this.photoURL});
}
