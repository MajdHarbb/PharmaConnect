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
  List<Marker> allMarkers = [];
  List<Marker> _markers = [];

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
      print("aa3333$data");
      for (int i = 0; i < data.length; i++) {
        LatLng latlng = new LatLng(double.parse(data[i]["latitude"]),double.parse(data[i]["longitude"]));
        this._markers.add(Marker(
              markerId: MarkerId(data[i]["id"]),
              position: latlng,
            ));
        print("hes${data[i]["longitude"]}");
      }
      print("amjds");
      setState(() {
        _loadedPhotos = data;
        allMarkers=_markers;
        print("a3333333333333${_loadedPhotos[0]["building"]}");
      });
    }
  }

  LatLng latlng = LatLng(
    -33.8670522,
    151.1957362,
  );
  @override
  //List<Marker> list = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    LatLng latlng = new LatLng(double.parse("38.123"), double.parse("35.123"));
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: latlng,
        infoWindow: InfoWindow(title: 'The title of the marker')));

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: GoogleMap(
        // myLocationEnabled: false,
        markers: Set<Marker>.of(allMarkers),
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
        initialCameraPosition: const CameraPosition(
          target: LatLng(32.1749132, 74.1779387),
          zoom: 5.0,
        ),
      ),
    );
  }
}
