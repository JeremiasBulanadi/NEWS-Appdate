// Tried this for quick prototyping
// Broken as heck
// Will be replaced entirely

import 'package:flutter/material.dart';
import 'package:news_appdate/models/aylien_data.dart';
import '../pages/newsPage.dart';

class NewsCard extends StatelessWidget {
  NewsCard({required this.story});

  Story story;

  @override
  Widget build(BuildContext context) {
    String placeholderImage = 'lib/assets/placeholder.jpg';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        ListTile(
            leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: FadeInImage.assetNetwork(
                    placeholder: placeholderImage,
                    image: story.media == null || story.media!.length == 0
                        ? placeholderImage
                        : story.media?.first.url ?? placeholderImage)),
            title: Text(story.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  Text(story.publishedAt.toString(),
                      style: TextStyle(color: Colors.black.withOpacity(0.6))),
                  Text(
                      // More stupid code due to null safety
                      (story.locations?.length == 0
                              ? "N/A"
                              : story.locations?.first.text) ??
                          "N/A",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)))
                ])),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            // Stupid ahead
            (story.summary?.sentences?.length == 0
                    ? "Click \"View\" to read more"
                    : story.summary?.sentences?.first) ??
                "Click \"View\" to read more",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            softWrap: true,
            style:
                TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            FlatButton(
              textColor: Colors.blue,
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsPage(story: story)))
              },
              child: Text(
                'View',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
