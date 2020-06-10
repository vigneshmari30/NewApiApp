import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ApiApp());
}

class ApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "ApiApp", home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future _getNews() async {
    var inputApi =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=71df993364e44f13bdd98055d6c8ac4e";

    var _getData = await http.get(inputApi);

    var _new = json.decode(_getData.body);

    print(_new['status']);
    print(_new['totalResults']);
    print(_new['articles'].length);

    return _new;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Api App"),
        ),
        body: Container(
          child: FutureBuilder(
              future: _getNews(),
              builder: (context, snapshot) {
                print("Articls:${snapshot.data['articles'].length}");

                return ListView.builder(
                    itemCount: snapshot.data['articles'].length,
                    itemBuilder: (BuildContext context, int index) {
                      var newApi = snapshot.data['articles'][index];

                      return Card(
                        elevation: 8,
                        child: Column(
                          children: <Widget>[
                            Image.network(
                                newApi['urlToImage']),
                            Text()
                          ],
                        ),
                      );
                    });
              }),
        ));
  }
}
