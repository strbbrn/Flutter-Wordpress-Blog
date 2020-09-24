import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Container(
        padding: const EdgeInsets.all(15.0),
          child: Center(
        child: Text("Leave a mail : skybirdwebmedia@gmail.com (or) pradeepkmrofficial@gmail.com",style: TextStyle(fontSize:15),),
      )),
    );
  }
}
