import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class SolvedPost extends StatefulWidget {
  final String postid;
  const SolvedPost({ Key? key, required this.postid }) : super(key: key);
  
  

  @override
  State<SolvedPost> createState() => _SolvedPostState();
}

class _SolvedPostState extends State<SolvedPost> {
  List _loadedPhotos = [];
  late String access_Token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Text(widget.postid),)
    );
  }





   // The function that fetches data from the API
  Future<void> fetchPharmacies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      access_Token = prefs.getString('accesToken')!;
    });
    const API_URL = 'http://192.168.0.117:8000/api/user/get-pharmacies';

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
      print(_loadedPhotos[1]["district"]);
    });
  }
}