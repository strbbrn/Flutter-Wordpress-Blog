import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("About Us")
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child:Text("Apnagharaunda.com (or) Android App is a part of SkyBird Web Media Pvt Ltd, Ranchi, Jharkhand, Which provides you a wide collection of Poetry , latest posts regarding politics, technology. For more information Contact us. ",style: TextStyle(fontSize:20),)
      ),
    );
  }
}