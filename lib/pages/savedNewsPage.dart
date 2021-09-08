import 'package:flutter/material.dart';

class SavedNews extends StatefulWidget {
  const SavedNews({ Key? key }) : super(key: key);

  @override
  _SavedNewsState createState() => _SavedNewsState();
}

class _SavedNewsState extends State<SavedNews> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
        title: Text('Saved News'),
        backgroundColor: Colors.green[400],
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),),
       ),
    body: Column(
      children: [
      Expanded(
      child: ListView(
      padding: EdgeInsets.all(15),
      scrollDirection: Axis.vertical,
      children: [
        firstCard(),secondCard(),thirdCard(),
      ],
    ),
  ),
  ]
));
  Widget firstCard() => Card(
   clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ), child: Image.network('https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='),
              ),
          title: const Text('Lorem Ipsum',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text('Date;',style: TextStyle(color: Colors.black.withOpacity(0.6))),
              Text('Locations;',style: TextStyle(color: Colors.black.withOpacity(0.6)))
            ]
          )
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [ 
            FlatButton(
              textColor: Colors.blue,
              onPressed: (){},
              child: Text('View',style: TextStyle(fontSize: 15),),
         
        ),
      ],
    ),
   ]
  ), 
);
  Widget secondCard() => Card(
       clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ), child: Image.network('https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='),
              ),
          title: const Text('Lorem Ipsum',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text('Date;',style: TextStyle(color: Colors.black.withOpacity(0.6))),
              Text('Locations;',style: TextStyle(color: Colors.black.withOpacity(0.6)))
            ]
          )
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [ 
            FlatButton(
              textColor: Colors.blue,
              onPressed: (){},
              child: Text('View',style: TextStyle(fontSize: 15),),
         
        ),
      ],
    ),
   ]
  ), 
  );
  Widget thirdCard() => Card(
       clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ), child: Image.network('https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='),
              ),
          title: const Text('Lorem Ipsum',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text('Date;',style: TextStyle(color: Colors.black.withOpacity(0.6))),
              Text('Locations;',style: TextStyle(color: Colors.black.withOpacity(0.6)))
            ]
          )
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [ 
            FlatButton(
              textColor: Colors.blue,
              onPressed: (){},
              child: Text('View',style: TextStyle(fontSize: 15),),
         
        ),
      ],
    ),
   ]
  ), 
 );
}