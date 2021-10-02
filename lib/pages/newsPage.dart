import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/database.dart';
import '../models/user.dart';
import '../models/location.dart';
import '../models/aylien_data.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key, required this.story}) : super(key: key);
  final Story story;

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String placeholderImage = 'lib/assets/placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    AppUser? appUser = Provider.of<AppUser?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        print("I should be sharing right now");
                        Share.share(widget.story.links?.permalink ?? "");
                      },
                      icon: Icon(
                        Icons.share,
                        size: 26.0,
                      ),
                    ),
                  ),
                  FutureBuilder<bool>(
                      future: DatabaseService().isStorySaved(
                          appUser?.uid, widget.story.id.toString()),
                      builder: (context, snapshot) {
                        return Opacity(
                          opacity: (appUser != null) ? 1 : 0.5,
                          child: IconButton(
                              onPressed: () async {
                                print(snapshot);
                                if (appUser == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        'You must be logged in to save stories'),
                                    duration: const Duration(seconds: 2),
                                  ));
                                } else if (snapshot.hasError) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        'There was an error, please try logging in and out again'),
                                    duration: const Duration(seconds: 2),
                                  ));
                                } else if (snapshot.data ?? false) {
                                  setState(() {
                                    DatabaseService()
                                        .unsaveStory(appUser.uid, widget.story)
                                        .then((val) {
                                      print("Dis be saved? ${snapshot.data}");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                            'Story sucessfully removed from bookmarks'),
                                        duration: const Duration(seconds: 1),
                                      ));
                                    });
                                  });
                                } else {
                                  setState(() {
                                    DatabaseService()
                                        .saveStory(appUser.uid, widget.story)
                                        .then((val) {
                                      print("Dis be saved? ${snapshot.data}");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                            'Story sucessfully added to bookmarks'),
                                        duration: const Duration(seconds: 1),
                                      ));
                                    });
                                  });
                                }
                              },
                              icon: Icon(
                                (snapshot.data ?? false)
                                    ? Icons.bookmark_added
                                    : Icons.bookmark_border,
                                size: 26.0,
                              )),
                        );
                      })
                ],
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Align(
                child: Text(
                  widget.story.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Align(
                child: InkWell(
                    child: Text(
                      widget.story.links?.permalink ?? "N/A",
                      style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                              text: widget.story.links?.permalink ?? ""))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Link copied to clipboard'),
                          duration: const Duration(seconds: 1),
                        ));
                      });
                    }),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: FadeInImage.assetNetwork(
                    placeholder: placeholderImage,
                    image: widget.story.media == null ||
                            widget.story.media!.length == 0
                        ? placeholderImage
                        : widget.story.media?.first.url ?? placeholderImage)),
            Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Text(widget.story.body ?? "N/A")),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Align(
                child: Text(widget.story.hashtags?.join("   ") ?? "No hashtags",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
            ),
            Align(
              child: Column(
                children: [
                  Align(
                    child: Padding(
                      child: Text(
                        'Locations:',
                        style: TextStyle(color: Colors.black54),
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Column(
                      children: [
                        for (Loc location in widget.story.locations ?? [])
                          ListTile(
                            title: Text(location.text),
                            subtitle: Text(location.addressFromPlacemark ??
                                "Cannot find location"),
                          ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            )
          ],
        ),
      ),
    );
  }
}
