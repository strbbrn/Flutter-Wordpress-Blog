import 'package:apnagharaunda/models/FavPost.dart';
import 'package:apnagharaunda/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';
import 'package:apnagharaunda/utils/DatabaseHelper.dart';

class DetailsPost extends StatefulWidget {
  final Posts post;
  DetailsPost(this.post);

  @override
  _DetailsPostState createState() => _DetailsPostState();
}

class _DetailsPostState extends State<DetailsPost> {
  
  String img;
  bool isButtonDisabled = false;
  void disable() async {
    if (await check(widget.post.title.rendered) != true) {
      setState(() {
        isButtonDisabled = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.disable();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    if (widget.post.jetpackFeaturedMediaUrl.isEmpty) {
      img = "https://via.placeholder.com/350x150";
    } else {
      img = widget.post.jetpackFeaturedMediaUrl;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        elevation: 2.0,
      ),
      body: ListView(children: [
        Stack(children: [
          Center(
              child: Image(
            image: NetworkImage(img),
            fit: BoxFit.fill,
            width: _width,
          )),
          Container(
            child: Center(
                child: Html(
              data: widget.post.title.rendered,
              defaultTextStyle: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            )),
            padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
          )
        ]),
        Container(
          child: Row(
            children: <Widget>[
              Text("Published on: " + widget.post.date.substring(0,10),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              Container(
                  padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: isButtonDisabled
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      color: Colors.white,
                      disabledColor: Colors.red,
                      onPressed: isButtonDisabled
                          ? null
                          : () async {
                              await PostDatabaseProvider.db.addPostToDatabase(
                                  new DbPost(
                                      widget.post.title.rendered,
                                      widget.post.content.rendered,
                                      widget.post.date,
                                      widget.post.eEmbedded.author[0].name,
                                      widget.post.eEmbedded.author[0]
                                          .description));

                              setState(() {
                                isButtonDisabled = true;
                              });
                              final snackBar = SnackBar(
                                content: Text('Yay! Post Added To Favourite!'),
                                action: SnackBarAction(
                                  label: 'Ok',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              // Find the Scaffold in the widget tree and use
                              // it to show a SnackBar.
                              Scaffold.of(context).showSnackBar(snackBar);
                            },
                    ),
                  )),
            ],
          ),
          height: 50,
          padding: EdgeInsets.fromLTRB(30, 10, 2, 0),
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 66, 9)),
        ),
       
        Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              children: <Widget>[
                IconButton(
                  
                  icon: Icon(Icons.share),
                  color: Colors.white,
                  disabledColor: Colors.red,
                  onPressed: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share("Check out the post " + widget.post.link,
                        subject: "Follow the page to get updated",
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                ),
                Text("Share Post")
              ],
            )),
        Container(
            padding: EdgeInsets.fromLTRB(15, 2, 5, 2),
            child: Center(
                child: Html(
              data: widget.post.content.rendered,
              defaultTextStyle: TextStyle(fontSize: 18, color: Colors.white),
              backgroundColor: Colors.transparent,
            ))),
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(58, 66, 66, 9),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                bottomRight: Radius.circular(35.0),
              )),
          padding: EdgeInsets.fromLTRB(2, 10, 2, 5),
          margin: EdgeInsets.all(8.0),
          height: 320,
          child: Column(
            children: <Widget>[
              Center(
                  child: Text("Author's Profile",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _width / 20,
                          color: Colors.white))),
              new SizedBox(
                height: _height / 25,
              ),
              new CircleAvatar(
                radius: _width < _height ? _width / 7 : _height / 7,
                backgroundImage: NetworkImage(
                    widget.post.eEmbedded.author[0].avatarUrls.s96),
              ),
              new SizedBox(
                height: _height / 25.0,
              ),
              new Text(
                widget.post.eEmbedded.author[0].name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _width / 15,
                    color: Colors.white),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                    top: _height / 30, left: _width / 8, right: _width / 8),
                child: new Text(
                  widget.post.eEmbedded.author[0].description,
                  style: new TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

Future check(String title) async {
  List<DbPost> data = await PostDatabaseProvider.db.getAllPosts();

  for (var user in data) {
    if (title == user.title) {
      return false;
    }
  }
  return true;
}
