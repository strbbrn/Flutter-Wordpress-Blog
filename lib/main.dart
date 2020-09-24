import 'dart:io';
import 'package:apnagharaunda/More.dart';
import 'package:apnagharaunda/Fav.dart';
import 'package:flutter/material.dart';
import 'package:apnagharaunda/models/fabbottom.dart';
import 'package:apnagharaunda/post.dart';
import 'package:apnagharaunda/Category.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Apnagharunda',
      theme: ThemeData.dark(),
      home: new MyHomePage(title: 'ApnaGharaunda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final pagecontroller = PageController();
  int currentIndex = 0;
  final _widgetOptions = [Post(), Cat(), Fav(), More()];
  void _selectedTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        
      }
    } on SocketException catch (_) {
     
      setState(() {
        currentIndex=2;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(index: currentIndex, children: _widgetOptions),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Menu',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.menu, text: ''),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: ''),
          FABBottomAppBarItem(iconData: Icons.favorite, text: ''),
          FABBottomAppBarItem(iconData: Icons.more, text: ''),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
