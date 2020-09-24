import 'package:apnagharaunda/DetailsPost.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apnagharaunda/models/posts.dart';

final List<String> imgList = [
  'assets/0.jpg',
  'assets/1.jpeg',
  'assets/2.jpg',
  'assets/3.jpeg',
  'assets/4.png'
];

final List child = map<Widget>(
  imgList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.asset(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'ApnaGharaunda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with AutomaticKeepAliveClientMixin<Post> {
  int maxlength = 25;

  List<dynamic> stringList = new List();
  int status = 0;
  List<Posts> posts = [];

  Future<List<Posts>> _fetchpost() async {
    try {
      final response = await http.get(
          Uri.encodeFull(
              'https://apnagharaunda.com/wp-json/wp/v2/posts?_embed&per_page=100'),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        for (int i = 0; i < maxlength; i++) {
          Posts postz = Posts.fromJson(json.decode(response.body)[i]);
          posts.add(postz);
        }
       
        setState(() {
          status = 1;
        });
      } else {
        setState(() {
          status = 2;
        });
      }
    } catch (e) {
     
      setState(() {
        status = 2;
      });
    }
    return posts;
  }

  @override
  void initState() {
    super.initState();
    this._fetchpost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return status == 1
        ? Column(children: <Widget>[
            CarouselSlider(
              items: child,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(
                imgList,
                (index, url) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                },
              ),
            ),
            Container(
                child: Text("Latest Posts",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ))),
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, index) {
                return Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        title: Html(
                          data: posts[index].title.rendered,
                          defaultTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Icon(Icons.linear_scale,
                                color: Colors.yellowAccent),
                            Text(
                                "  Author: " +
                                    posts[index].eEmbedded.author[0].name,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: Colors.white, size: 30.0),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPost(posts[index])));
                        },
                      ),
                    ));
              },
              itemCount: posts.length,
            ))
          ])
        : status == 0
            ? Container(
                child: Center(
                    child: Image(image: AssetImage("assets/loading.gif"))))
            : Container(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Text(
                    "No Internet,",
                    style: TextStyle(fontSize: 20),
                  )),
                  Center(
                      child: Text(
                    "You can still read your favorite posts",
                    style: TextStyle(fontSize: 20),
                  )),
                ],
              ));
  }

  @override
  bool get wantKeepAlive => true;
}
