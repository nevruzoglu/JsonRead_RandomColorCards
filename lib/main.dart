import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url = 'https://swapi.co/api/people/';
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Json File Read'),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: Text(data[index]['name']),
                            padding: EdgeInsets.all(20),
                          ),
                        )
                      ]),
                ),
              );
            }),
      ),
    );
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //encode url
        Uri.encodeFull(url),
        //only accept json
        headers: {'Accept': 'application/json'});
    print(response.body);
    setState(() {
      var convertDatatoJson = jsonDecode(response.body);
      data = convertDatatoJson['results'];
    });
    return "Success";
  }
}
