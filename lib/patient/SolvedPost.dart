import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/map/map_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SolvedPost extends StatefulWidget {
  //get post id from activity page
  final String postid;
  const SolvedPost({Key? key, required this.postid}) : super(key: key);

  @override
  State<SolvedPost> createState() => _SolvedPostState();
}

class _SolvedPostState extends State<SolvedPost> {
  List _pharmaciesList = [];
  late String access_Token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Pharmacies'),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                //color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(
                            'http://192.168.0.117:8000/profiles/${_pharmaciesList[index]["profile_pic"]}',
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _pharmaciesList[index]["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'member since ${_pharmaciesList[index]["updated_at"].substring(0, _pharmaciesList[index]["updated_at"].indexOf('T'))}',
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
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                        '${_pharmaciesList[index]["building"]}, ${_pharmaciesList[index]["street"]}'),
                    Text('${_pharmaciesList[index]["district"]}'),
                    Text('${_pharmaciesList[index]["locality"]}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            MapUtils.openMap(_pharmaciesList[index]["latitude"],
                                _pharmaciesList[index]["longitude"]);
                          },
                          label: const Text(
                            'Maps',
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
                            MapUtils.openDialer(
                                '${_pharmaciesList[index]["phone"]}');
                          },
                          label: const Text(
                            'Call',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.email_rounded,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            MapUtils.openMail(
                                '${_pharmaciesList[index]["email"]}');
                          },
                          label: const Text(
                            'Email',
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
            childCount: _pharmaciesList.length,
            // 1000 list items
          ),
        ),
      ],
    ));
  }

  // The function that fetches data from the API
  Future<void> fetchPharmacies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      access_Token = prefs.getString('accesToken')!;
    });
    //fetch pharmacies that replied to the specific post id got from activity page (line 10)
    final APIURL =
        'http://192.168.0.117:8000/api/user/pharmacy-by-post?post_id=${widget.postid}';

    final response = await http.get(
      Uri.parse(APIURL),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
    );
    final data = json.decode(response.body);
    //set json in pharmacy list
    setState(() {
      _pharmaciesList = data;
    });
  }

  @override
  initState() {
    super.initState();
    fetchPharmacies();
  }
}
