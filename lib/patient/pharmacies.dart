import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/map/map_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
class PatientPharmacies extends StatefulWidget {
  const PatientPharmacies({Key? key}) : super(key: key);

  @override
  _PatientPharmaciesState createState() => _PatientPharmaciesState();
}

class _PatientPharmaciesState extends State<PatientPharmacies> {
  @override
    // The list that contains information about photos
  List _loadedPhotos = [];
  String access_Token = "";

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      access_Token = prefs.getString('accesToken')!;
    });
    const API_URL = 'http://192.168.0.117:8000/api/user/get-pharmacies';

    final response = await http.get(Uri.parse(API_URL),
    headers: {
        'Authorization': 'Bearer $access_Token',
      },
    );
    final data = json.decode(response.body);
    print(data);

    setState(() {
      _loadedPhotos = data;
      print(_loadedPhotos[1]["district"]);
    });
  }
  initState() {
    super.initState();
    print(
        "hello =========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>;d");
    _fetchData();
  }
  Widget build(BuildContext context) {
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
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "1 hour ago",
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
                    const Text("Post Caption"),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            MapUtils.openMap(-55.42657, -93.39159);
                          },
                          label: const Text(
                            'View',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            print("test");
                          },
                          label: const Text(
                            'Call',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            print("test");
                          },
                          label: const Text(
                            'Share',
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
    )
    );
  }
}
