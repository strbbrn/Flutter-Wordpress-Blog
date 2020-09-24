import 'package:apnagharaunda/DetailsFavPost.dart';
import 'package:flutter/material.dart';
import 'package:apnagharaunda/models/FavPost.dart';
import 'package:apnagharaunda/utils/DatabaseHelper.dart';
import 'package:flutter_html/flutter_html.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  List posts;
  int status = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: Text("Refresh")),
              Center(child: Icon(Icons.refresh))
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<DbPost>>(
            future: PostDatabaseProvider.db.getAllPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<DbPost>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    DbPost item = snapshot.data[index];
                    return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: Center(
                              child: Text(
                            "Swipe to Delete",
                            style: TextStyle(fontSize: 20),
                          )),
                        ),
                        onDismissed: (direction) {
                          PostDatabaseProvider.db.deletePostWithId(item.id);
                        },
                        child: Card(
                            elevation: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                title: Html(
                                  data: item.title,
                                  defaultTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Icon(Icons.linear_scale,
                                        color: Colors.yellowAccent),
                                    Text("  Author: " + item.author,
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
                                              DetailsFavPost(item)));
                                },
                              ),
                            )));
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
