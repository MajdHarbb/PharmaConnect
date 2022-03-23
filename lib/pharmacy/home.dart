import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PharmacyHome extends StatefulWidget {
  const PharmacyHome({Key? key}) : super(key: key);

  @override
  State<PharmacyHome> createState() => _PharmacyHomeState();
}

class _PharmacyHomeState extends State<PharmacyHome> {
  List _loadedPhotos = [];
  String access_Token = "";
  String user_id = "";

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      access_Token = prefs.getString('accesToken')!;
      user_id = prefs.getString('id')!;
    });
    const API_URL = 'http://192.168.0.117:8000/api/user/get-posts';

    final response = await http.get(
      Uri.parse(API_URL),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
    );
    final data = json.decode(response.body);
    print(data);

    setState(() {
      _loadedPhotos = data;
      print(_loadedPhotos[1]["name"]);
    });
  }

  Future<void> SolvePost() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/solvePost'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'post_id': '2',
        'poster_id': '35',
        'pharmacy_id': user_id,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print(response.body);
      print("===========> done");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      var bod = response.body;
      print("$bod hhhhhhhhhhhhhhh");
      print("errorrrrrrrrrrrrrr!");
    }
  }

  initState() {
    super.initState();
    print(
        "hello =========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>;d");
    _fetchData();
    print("==========> LENGHT");
    print("id ===> $user_id");
    print(access_Token);
  }

  @override
  Widget build(BuildContext context) {
    print(_loadedPhotos.length);
    print("id ===> $user_id");
    print(access_Token);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        // const SliverAppBar(
        //   backgroundColor: Colors.amber,
        //   title: Text('Kindacode.com'),
        //   expandedHeight: 30,
        //   collapsedHeight: 150,
        // ),
        const SliverAppBar(
          //backgroundColor: Colors.green,
          title: Text('Pharmacies'),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.grey[200],
                          //backgroundImage: NetworkImage("assets\images\test.jpg"),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _loadedPhotos[index]["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    _loadedPhotos[index]["updated_at"],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Icon(
                                    Icons.public,
                                    color: Colors.grey[600],
                                    size: 12.0,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () {
                            print('more');
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(_loadedPhotos[index]["post_text"]),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(
                        'assets/images/aspirin.jpg',
                        width: 600.0,
                        height: 240.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80.0, 60.0),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            SolvePost();
                          },
                          label: const Text(
                            'Send Availability Message',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            childCount: _loadedPhotos.length, // 1000 list items
          ),
        ),
      ],
    ));
  }
}
