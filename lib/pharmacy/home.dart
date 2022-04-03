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
  String user_name = "";
  String user_email = "";
  String user_phone = "";
  String user_profile_picture = "";
    
    Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('http://192.168.0.117:8000/api/user/info?user_id=$user_id'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },

    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var response_jsondata = json.decode(response.body);
      print("here ======================>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(response_jsondata);
      //var user_json_id = json.decode(response_jsondata);
      final String nameJson = (response_jsondata["user"][0]["name"]).toString();
      final String emailJson =(response_jsondata["user"][0]["email"]).toString();
      final String phoneJson =(response_jsondata["user"][0]["phone"]).toString();
      final String profileJson =(response_jsondata["user"][0]["profile_pic"]).toString();
      print("user iddddddddddddddddddddd ===================>>>>>>>>>>");
      print(nameJson);
      print(emailJson);

      print(phoneJson);
      print(profileJson);
      print("======================>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(response.body);
      
      await prefs.setString('name', nameJson);
      await prefs.setString('email', emailJson);
      await prefs.setString('phone', phoneJson);
      await prefs.setString('profile_pic', profileJson);
      // final String? action = prefs.getString('name');
      // final String? action2 = prefs.getString('email');
      // final String? action3 = prefs.getString('phone');
      // final String? action4 = prefs.getString('phone');
      setState(() {
      user_name = prefs.getString('name')!;
      user_email = prefs.getString('email')!;
      user_phone = prefs.getString('phone')!;
      user_profile_picture = prefs.getString('profile_pic')!;
    });

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
  // The function that fetches data from the API
  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      access_Token = prefs.getString('accesToken')!;
      user_id = prefs.getString('id')!;
    });

    final response = await http.get(
      Uri.parse(
          'http://192.168.0.117:8000/api/pharmacy/get-unsolved-posts?$user_id'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
    );
    final data = json.decode(response.body);

    setState(() {
      _loadedPhotos = data;
    });
    
  }

  Future<void> SolvePost(postId, posterId) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/solvePost'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'post_id': postId,
        'poster_id': posterId,
        'pharmacy_id': user_id,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print(response.body);
      print("===========> done");
      _fetchData();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Availability notification sent, Thank you!'),
          content: const Text('Press okay to return to your screen'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
    getUserInfo();
    print("==========> LENGHT");
    print("id ===> $user_id");
    print(access_Token);
  }

  @override
  Widget build(BuildContext context) {
    print(_loadedPhotos.length);
    print("id ===> $user_id");
    print(access_Token);
    print(user_profile_picture);
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
                          backgroundImage: NetworkImage(
                              'http://192.168.0.117:8000/profiles/${_loadedPhotos[index]["profile_pic"]}'),
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
                                    _loadedPhotos[index]["updated_at"]
                                        .substring(
                                            0,
                                            _loadedPhotos[index]["updated_at"]
                                                .indexOf('T')),
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
                    Text(_loadedPhotos[index]["post_text"]),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(
                        'http://192.168.0.117:8000/posts/${_loadedPhotos[index]["post_pic"]}',
                        width: 600.0,
                        height: 240.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80.0, 60.0),
                            primary: Colors.white,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                          ),

                          onPressed: () {
                            print("yess");
                          },
                          label: const Text(
                            'Ignore',
                            style: TextStyle(color: Colors.red),
                          ),
                          //controller: streetController,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.green,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80.0, 60.0),
                            primary: Colors.white,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                          ),

                          onPressed: () {
                            SolvePost((_loadedPhotos[index]["id"]).toString(),
                                (_loadedPhotos[index]["user_id"].toString()));
                          },
                          label: const Text(
                            'Available',
                            style: TextStyle(color: Colors.green),
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
