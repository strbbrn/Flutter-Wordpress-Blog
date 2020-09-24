import 'package:apnagharaunda/models/FavPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsFavPost extends StatefulWidget {
  final DbPost item;
  DetailsFavPost(this.item);
  @override
  _DetailsFavPostState createState() => _DetailsFavPostState();
}

class _DetailsFavPostState extends State<DetailsFavPost> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Post"), elevation: 2.0),
      body: ListView(children: [
        Stack(children: [
          Container(
            child: Center(
                child: Html(
              data: widget.item.title,
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
              Container(
                child: Text("Published on: " + widget.item.date.substring(0,10),
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                        padding: EdgeInsets.fromLTRB(30, 10, 2, 0),
              ),
            ],
          ),
          height: 50,
          
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 66, 9)),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(15, 2, 5, 2),
            child: Center(
                child: Html(
              data: widget.item.description,
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
          height: 220,
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
              new SizedBox(
                height: _height / 25.0,
              ),
              new Text(
                widget.item.author,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _width / 15,
                    color: Colors.white),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                    top: _height / 30, left: _width / 8, right: _width / 8),
                child: new Text(
                 widget.item.authorDescription,
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
