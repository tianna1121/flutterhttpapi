import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: StarWarsData(),
  ));
}

class StarWarsData extends StatefulWidget {
  @override
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {
  final String url = "https://swapi.co/api/starships";
  List data;

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars starships"),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Text("Name: "),
                          new Text(
                            data[index]["name"],
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Text("Model: "),
                          new Text(
                            data[index]["model"],
                            style: TextStyle(fontSize: 18.0, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Text("Cargo Capacity: "),
                          new Text(
                            data[index]["cargo_capacity"],
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}
