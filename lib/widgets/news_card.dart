import 'package:flutter/material.dart';
import 'package:news_appdate/models/aylien_data.dart';

class NewsCard extends StatelessWidget {
  NewsCard({required this.story});

  Story story;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(story.title),
            ],
          ),
        ),
      ),
    );
  }
}
