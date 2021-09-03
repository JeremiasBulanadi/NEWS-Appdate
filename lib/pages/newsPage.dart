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
        title: Text('News Page'),
        backgroundColor: Colors.green[400],
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 25),
            child: Text('Lorem ipsum', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),),
            Padding(padding: EdgeInsets.only(bottom: 25),
            child: Image.asset('lib/assets/placeholder.jpg'),),
            Padding(padding: EdgeInsets.only(bottom: 25),
            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')),
            Padding(padding: EdgeInsets.only(bottom: 25),
            child: Text('#hell yeah', style: TextStyle(color: Colors.blue),),),
            Text('Location: Placeholder', style: TextStyle(color: Colors.black54),)
         ],
      ),),
    );
  }
}