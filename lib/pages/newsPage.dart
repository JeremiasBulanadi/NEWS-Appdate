import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({ Key? key }) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lorem Ipsum'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),),
        actions: [
          Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
          onTap: () {},
          child: Icon(
              Icons.share,
              size: 26.0,
              ),
            )
          ),
        ],
      ),
      body: SingleChildScrollView(child: ,),
    );
  }
}