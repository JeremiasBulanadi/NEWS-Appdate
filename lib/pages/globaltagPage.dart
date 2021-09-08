import 'package:flutter/material.dart';

class GlobalTags extends StatefulWidget {
  const GlobalTags({ Key? key }) : super(key: key);

  @override
  _GlobalTagsState createState() => _GlobalTagsState();
}

class _GlobalTagsState extends State<GlobalTags> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Hashtags'),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              ListTile(
                title: Text('Placeholder_Hashtag1'),
                leading: CircleAvatar(
                  backgroundColor: Colors.green[200],
                  child: Text("#", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
                trailing: Text('Score: 5'),
              ),
              ListTile(
                title: Text('Placeholder_Hashtag2'),
                leading: CircleAvatar(
                  backgroundColor: Colors.green[200],
                  child: Text("#", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
                trailing: Text('Score: 5'),
              ),
              ListTile(
                title: Text('Placeholder_Hashtag3'),
                leading: CircleAvatar(
                  backgroundColor: Colors.green[200],
                  child: Text("#", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
                trailing: Text('Score: 5'),
              ),
            ],
          ))
        ],),
    );
  }
}