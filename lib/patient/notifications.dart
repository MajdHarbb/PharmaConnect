import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/map/map_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  // The list that contains information about photos
  List _loadedPhotos = [];
  String access_Token = "";
  String user_id = "";
  int count = 0;

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      access_Token = prefs.getString('accesToken')!;
      user_id = prefs.getString('id')!;
    });
    const API_URL = 'http://192.168.0.117:8000/api/user/get-notifications';

    final response = await http.post(
      Uri.parse(API_URL),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
      },
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
        setState(() {
          count =1;
        _loadedPhotos = data;

      });
    }else {
      setState(() {
        // _loadedPhotos.length = 0;
        count =0;
        _loadedPhotos = ["no notifications yet"];
        
      });
    }
    
  }

  initState() {
    super.initState();
    print(
        "hello =========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>;d");
    _fetchData();
    print("hereeeeeeeeeeeeeeeeeeee $count");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
        
      CustomScrollView(
      slivers: [

        // ),
        const SliverAppBar(
          //backgroundColor: Colors.green,
          title: Text('Notifications'),
          floating: true,
          leading: Icon(Icons.notifications_rounded,
    ),
        ),
        
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              
              return 
              count !=0? 
              Container(
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
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(8.0),
                child: 
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: 
                            NetworkImage('http://192.168.0.117:8000/profiles/${_loadedPhotos[index]["profile_pic"]}'),
     
                                ),

                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_loadedPhotos[index]["name"]}: Yes, it's available.",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey[600],
                                    size: 12.0,
                                  ),
                                  Text(
                                    "${_loadedPhotos[index]["building"]}, ${_loadedPhotos[index]["street"]}",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${_loadedPhotos[index]["locality"]}, ${_loadedPhotos[index]["district"]}",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text("${_loadedPhotos[index]["post_text"]}"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: 
                      Image.network('http://192.168.0.117:8000/posts/${_loadedPhotos[index]["post_pic"]}?v=${DateTime.now().millisecondsSinceEpoch}',width: 600.0,
                        height: 240.0,
                        fit: BoxFit.cover,),
                    ),
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
                            MapUtils.openMap(_loadedPhotos[index]["latitude"], _loadedPhotos[index]["longitude"]);
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
                            MapUtils.openDialer('${_loadedPhotos[index]["phone"]}');
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
                            MapUtils.openMail('${_loadedPhotos[index]["email"]}');
                          },
                          label: const Text(
                            'Mail',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                      ],
                    )
                  ],
                ),
              ) : 
              Container(
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
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(8.0),
                child: 
                const Text("You don't have any notifications"),
              ); 
              
            },
            childCount: _loadedPhotos.length, // 1000 list items
          ),
        ),
      ],
    ));
  }
}
