// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()


class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  // The list that contains information about photos
  List _loadedPhotos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const API_URL = 'https://jsonplaceholder.typicode.com/photos';

    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);

    setState(() {
      _loadedPhotos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kindacode.com'),
        ),
        body: SafeArea(
            child: _loadedPhotos.length == 0
                ? Center(
                    child: ElevatedButton(
                      child: Text('Load Photos'),
                      onPressed: _fetchData,
                    ),
                  )
                // The ListView that displays photos
                : ListView.builder(
                    itemCount: _loadedPhotos.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ListTile(
                        leading: Image.network(
                          _loadedPhotos[index]["thumbnailUrl"],
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        title: Text(_loadedPhotos[index]['title']),
                        subtitle:
                            Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
                      );
                    },
                  )));
  }
}