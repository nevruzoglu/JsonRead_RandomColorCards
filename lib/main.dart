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
                        color: RandomHexColor(Color(0xffFC6DAB),
                                Color(0xff5E2BFF), Color(0xffF7F6C5))
                            .colorRandom(),
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

// class RandomHexColor {
//   static const Color one = Color(0xffFC6DAB);
//   static const Color two = Color(0xff5E2BFF);
//   static const Color three = Color(0xffF7F6C5);

//   List<Color> hexColor = [one, two, three];

//   static final _random = Random();

//   Color colorRandom() {
//     return hexColor[_random.nextInt(3)];
//   }
// }

class RandomHexColor {
  Color one;
  Color two;
  Color three;
  List hexColor;

  RandomHexColor(this.one, this.two, this.three) : hexColor = [one, two, three];
  // same with > RandomHexColor(this.one, this.two, this.three) { hexColor = [one, two, three];}

  Color colorRandom() {
    // or can be use here > List hexColor = [one, two, three];
    return hexColor[Random().nextInt(3)];
  }
}

// class RandomColor<Color> {
//   List<MaterialColor> color = [
//     Colors.green,
//     Colors.blue,
//     Colors.indigo,
//   ];

//   var index = Random().nextInt(3);

//   MaterialColor colorRandomizer() {
//     print(color[index]);
//     return color[index];
//   }
// }
