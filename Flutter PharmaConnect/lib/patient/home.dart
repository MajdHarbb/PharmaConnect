import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/map/Map.dart';
import 'package:pharmaconnectflutter/patient/SolvedPost.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {

  String user_id = "";
  String user_type = "";
  String access_Token = "";
  String extension = "";
  String user_name = "";
  String user_email = "";
  String user_phone = "";
  String user_profile_picture = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello $user_name!'),
          leading: const Icon(Icons.home_rounded,),
        ),
        body: const Center(
          child: PharmaciesMap(),
        ));
  }
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
      var responseJsondata = json.decode(response.body);

      final String nameJson = (responseJsondata["user"][0]["name"]).toString();
      final String emailJson =(responseJsondata["user"][0]["email"]).toString();
      final String phoneJson =(responseJsondata["user"][0]["phone"]).toString();
      final String profileJson =(responseJsondata["user"][0]["profile_pic"]).toString();

      //set in shared prefs
      await prefs.setString('name', nameJson);
      await prefs.setString('email', emailJson);
      await prefs.setString('phone', phoneJson);
      await prefs.setString('profile_pic', profileJson);
      setState(() {
        user_name = prefs.getString('name')!;
        user_email = prefs.getString('email')!;
        user_phone = prefs.getString('phone')!;
        user_profile_picture = prefs.getString('profile_pic')!;
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to fetch data.');
    }
  }



  getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    //get shared prefs
    setState(() {
      user_id = prefs.getString('id')!;
      user_type = prefs.getString('user_type')!;
      access_Token = prefs.getString('accesToken')!;
    });
    
  }
  @override
  initState() {
    super.initState();
    getSharedPrefs();
    getUserInfo();
  }

}
