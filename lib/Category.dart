import 'dart:convert';
import 'package:apnagharaunda/services/GetCategoryPost.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cat extends StatefulWidget {
  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  int refresh = 0;
  List categories;
  Future getCategory() async {
    try {
      final response = await http.get(
          Uri.encodeFull(
              'https://apnagharaunda.com/wp-json/wp/v2/categories?_embed&per_page=100'),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        var decode = json.decode(response.body);
       

        setState(() {
          refresh = 1;
          categories = decode;
        });
      } else {
        setState(() {
          refresh = 2;
        });
      }
    } catch (e) {
     
      setState(() {
        refresh = 2;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return refresh == 1
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Categories",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
              Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              child: InkWell(
                                  child: Stack(children: [
                                    Image(
                                        image:
                                            AssetImage("assets/category.png")),
                                    Center(
                                        child: Text(categories[index]["name"]))
                                  ]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GetCategoryPost(
                                                    categories[index]["id"])));
                                  }),
                            ));
                      }))
            ],
          )
        : refresh == 0
            ? Container(
                child: Center(
                child: Image(image: AssetImage("assets/loading.gif")),
              ))
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
                ),
              );
  }
}
