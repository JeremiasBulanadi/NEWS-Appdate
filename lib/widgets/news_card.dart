// Tried this for quick prototyping
// Broken as heck
// Will be replaced entirely

import 'package:flutter/material.dart';
import 'package:news_appdate/models/aylien_data.dart';

class NewsCard extends StatelessWidget {
  NewsCard({required this.story});

  Story story;

  @override
  Widget build(BuildContext context) {
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
              child: Image.network(
                  // Stupid code due to flutter null safety ahead
                  story.media == null || story.media!.length == 0
                      ? 'https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='
                      : story.media?.first.url ??
                          'https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='),
            ),
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
                    ? "N/A"
                    : story.summary?.sentences?.first) ??
                "N/A",
            style:
                TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            FlatButton(
              textColor: Colors.blue,
              onPressed: () {},
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
