import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/SolvedPost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PateintNotifications extends StatefulWidget {
  const PateintNotifications({Key? key}) : super(key: key);

  @override
  State<PateintNotifications> createState() => _PateintNotificationsState();
}

class _PateintNotificationsState extends State<PateintNotifications> {
  int count = 0;
  String user_id = "";
  String user_type = "";
  String access_Token = "";
  String user_name = "";
  String user_profile_picture = "";

  List _notifications = []; //list to store api notifications

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: const Icon(
          Icons.notifications_rounded,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    count != 0
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
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
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundColor: Colors.grey[200],
                                          backgroundImage: NetworkImage(
                                              'http://192.168.0.117:8000/profiles/$user_profile_picture'),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    user_name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SolvedPost(
                                                                            postid:
                                                                                _notifications[index]["post_id"].toString(),
                                                                          )),
                                                            );
                                                          },
                                                          child: const Text("Pharmacy Replies"),),
                                                      const Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          color: Colors.blue, size: 15,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _notifications[index]
                                                            ["updated_at"]
                                                        .substring(
                                                            0,
                                                            _notifications[
                                                                        index][
                                                                    "updated_at"]
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
                                    Text(_notifications[index]["post_text"]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Image.network(
                                        'http://192.168.0.117:8000/posts/${_notifications[index]["post_pic"]}?v=${DateTime.now().millisecondsSinceEpoch}',
                                        width: 600.0,
                                        height: 240.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: _notifications.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            scrollDirection: Axis.vertical,
                          )
                        : Container(
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
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                                "You don't have any notifications yet, please wait for a reply"),
                          ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    setState(() {
      user_id = prefs.getString('id')!;
      user_type = prefs.getString('user_type')!;
      access_Token = prefs.getString('accesToken')!;
      user_name = prefs.getString('name')!;
      user_profile_picture = prefs.getString('profile_pic')!;
    });
    const API_URL = 'http://192.168.0.117:8000/api/user/post-pharmacies';

    final response = await http.get(
      Uri.parse(API_URL),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON and set JSON to notifications list
      setState(() {
        _notifications = data;
        count = _notifications.length;
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then set count = 0 (display no notifications yet message)

      setState(() {
        _notifications = ["no notifications yet"];
        count = 0;
      });
    }
  }

  @override
  initState() {
    super.initState();
    getStringValuesSF();
  }
}
