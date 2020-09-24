import 'dart:convert';
import 'package:apnagharaunda/DetailsPost.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:apnagharaunda/models/posts.dart';
import 'package:flutter/material.dart';

class GetCategoryPost extends StatefulWidget {
  final int id;
  GetCategoryPost(this.id);
  @override
  _GetCategoryPostState createState() => _GetCategoryPostState();
}

class _GetCategoryPostState extends State<GetCategoryPost> {
  int status = 0;
  List<Posts> posts = [];

  Future<List<Posts>> _fetchpost() async {
    try {
      final response = await http.get(
          Uri.encodeFull(
              'https://apnagharaunda.com/wp-json/wp/v2/posts?categories=${widget.id}&_embed&per_page=100'),
          headers: {"Accept": "application/json"});

      var decode = json.decode(response.body);

      if (decode.length == 0) {
       
        setState(() {
          status = 2;
        });
      } else if (decode.length == 1) {
        Posts postz = Posts.fromJson(json.decode(response.body)[0]);
        posts.add(postz);
        setState(() {
          status = 1;
        });
      } else {
        if (response.statusCode == 200) {
          for (int i = 0; i < decode.length; i++) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Posts"), elevation: 2.0),
      body: status == 1
          ? Column(children: <Widget>[
              Expanded(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  return Card(
                      elevation: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          title: Html(
                            data: posts[index].title.rendered,
                            defaultTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                      child: Image(
                  image: AssetImage("assets/loading.gif"),
                  height: 350,
                  width: 250,
                )))
              : Container(
                  child: Center(
                      child: Text(
                  "No Post For This Category",
                  style: TextStyle(fontSize: 20),
                ))),
    );
  }
}
