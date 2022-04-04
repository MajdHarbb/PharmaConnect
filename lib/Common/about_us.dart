import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List _loadedPhotos = [];
  String access_Token = "";
  String pharmacy_profile_pic = "";

  // The function that fetches data from the API
  Future<void> _fetchData() async {
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
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      // print("aa3333$data");
      Map responseBody = json.decode(response.body);
      
      List results = responseBody["result"];
      print("aa3333${results[0]["building"]}");
      setState(() {
        _loadedPhotos = data;
        // print("a3333333333333${results[0]}");
      });
    }
  }

  LatLng latlng = LatLng(
    -33.8670522,
    151.1957362,
  );
  Iterable markers = [];
  @override
  Set<Marker> _markers = {};
  Marker marker1 = Marker(
    markerId: MarkerId('Marker1'),
    position: const LatLng(32.195476, 74.2023563),
    infoWindow: InfoWindow(title: 'Business 1'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  );
  Marker marker2 = Marker(
    markerId: MarkerId('Marker2'),
    position: LatLng(31.110484, 72.384598),
    infoWindow: InfoWindow(title: 'Business 2'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
  List<Marker> list = [];

  @override
  void initState() {
    list = [marker1, marker2];
    // _markers.addAll(list);
    super.initState();
    _fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(list),
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
        initialCameraPosition: const CameraPosition(
          target: LatLng(32.1749132, 74.1779387),
          zoom: 11.0,
        ),
      ),
    );
  }
}
