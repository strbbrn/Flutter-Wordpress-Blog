import 'package:apnagharaunda/Contact.dart';
import 'package:apnagharaunda/Privacy.dart';
import 'package:flutter/material.dart';
import 'package:apnagharaunda/About.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      InkWell(
        child: Card(
          child: ListTile(
            title: Text("Privacy Policy"),
          ),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Privacy()));
        },
      ),
      InkWell(
        child: Card(
          child: ListTile(
            title: Text("Contact US"),
          ),
        ),
        onTap: () {
         Navigator.push(
              context, MaterialPageRoute(builder: (context) => Contact()));
        },
      ),
      InkWell(
        child: Card(
          child: ListTile(
            title: Text("About Us"),
          ),
        ),
        onTap: () {
         Navigator.push(
              context, MaterialPageRoute(builder: (context) => About()));
        },
      ),
    ]));
  }
}
