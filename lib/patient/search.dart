import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/widgets/expansionTile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PatientSearch extends StatefulWidget {
  const PatientSearch({Key? key}) : super(key: key);

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  List _loadedPhotos = [];
  String access_Token = "";
  String pharmacy_profile_pic = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Posts'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expansiontile(),
            Container(
              padding: const EdgeInsets.all(8.0),
                color: Colors.white,
              child: ExpansionTile(
                title: Row(children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "My Account",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "Edit Your Profile Information",
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

                ]),
                children: [
                  ListTile(
                    title: Container(
                  
                  child: Row(children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey[600],
                      size: 30.0,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "My Account",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Text(
                                "Edit Your Profile Information",
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

                  ]),
                ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      user_id = prefs.getString('id')!;
      user_type = prefs.getString('user_type')!;
      access_Token = prefs.getString('accesToken')!;
    });
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/my-posts'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
        // 'post_text': postTextController.text,
        // 'post_pic': "data:image/$extension;base64,$base64_img",
      },
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print(response.body);
      print("===========> done hh");
      setState(() {
      _loadedPhotos = data;
      count = _loadedPhotos.length;
    });
      
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("failed test${response.body}");
      setState(() {
      _loadedPhotos = ["no posts yet"];
      count = 0;
    });
    }
    


    print(user_id);
    print(user_type);


  }

  @override
  initState() {
    super.initState();
    print(
        "hello =========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>;d");
    getStringValuesSF();
    getUserInfo();
    
  }

  
}
