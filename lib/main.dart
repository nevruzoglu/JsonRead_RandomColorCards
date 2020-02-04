import 'dart:convert';
import 'dart:math';

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
          backgroundColor: Colors.grey.shade900,
          title: Text('Json File Read'),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        margin: EdgeInsets.all(5),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(data[index]['name']),
                              Text(data[index]['birth_year'])
                            ],
                          ),
                        ),
                      )
                    ]),
              );
            }),
      ),
    );
  }

  Future<String> getJsonData() async {
    http.Response response = await http.get(
        //encode url
        Uri.encodeFull(url),
        //only accept json
        headers: {'Accept': 'application/json'});

    setState(() {
      var convertDatatoJson = jsonDecode(response.body);
      data = convertDatatoJson['results'];
    });
    return "Success";
  }
}
