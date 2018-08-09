import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //Encode the url
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = JSON.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Fetch Json Data"),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: Center(
                child: Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Name : " + data[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("Name : " + data[index]['gender'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    padding: const EdgeInsets.all(20.0),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
