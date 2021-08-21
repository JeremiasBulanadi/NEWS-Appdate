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
    return Center(
      child: Card(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Image.network(story.media.first.url ?? "../assets/stop.png"),
          ListTile(
            leading: Icon(Icons.album),
            title: Text(story.title ?? "N/A"),
            subtitle: Text(story.summary?.sentences?[0] ?? "N/A"),
          )
        ],
      )),
    );
  }
}
