import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        size: 26.0,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.save,
                        size: 26.0,
                      ))
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
                      style: TextStyle(fontSize: 10),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                              text: widget.story.links?.permalink ?? ""))
                          .then((_) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Link copied to clipboard")));
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
                child: (widget.story.hashtags == null ||
                        widget.story.hashtags!.length == 0)
                    ? Text("No hashtags")
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.story.hashtags!.length,
                        itemBuilder: (context, index) {
                          final hashtag = widget.story.hashtags?[index];

                          if (hashtag != null) {
                            return ListTile(
                              title: Text(hashtag),
                            );
                          } else {
                            return ListTile(
                              title: Text("N/A"),
                            );
                          }
                        }),
                alignment: Alignment.centerLeft,
              ),
            ),
            Align(
              child: Column(
                children: [
                  Align(
                    child: Text(
                      'Locations:',
                      style: TextStyle(color: Colors.black54),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Row(
                      children: [
                        Text(
                          'Placeholder1',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: IconButton(
                              icon: Icon(Icons.location_searching_outlined,
                                  size: 15),
                              onPressed: () {}),
                        )
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Row(
                      children: [
                        Text(
                          'Placeholder2',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: IconButton(
                              icon: Icon(Icons.location_searching_outlined,
                                  size: 15),
                              onPressed: () {}),
                        )
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Row(
                      children: [
                        Text(
                          'Placeholder3',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: IconButton(
                              icon: Icon(Icons.location_searching_outlined,
                                  size: 15),
                              onPressed: () {}),
                        )
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  )
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
