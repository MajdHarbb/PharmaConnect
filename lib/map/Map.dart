import 'dart:convert';
import 'dart:typed_data';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class PharmaciesMap extends StatefulWidget {
  const PharmaciesMap({Key? key}) : super(key: key);

  @override
  State<PharmaciesMap> createState() => _PharmaciesMapState();
}

class _PharmaciesMapState extends State<PharmaciesMap> {
  List _loadedPhotos = [];
  String access_Token = "";
  String pharmacy_profile_pic = "";
  List<Marker> _markers = [];
  List<Marker> _list = [];
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

      print("amjds");

      _loadedPhotos = data;
      for (int i = 0; i < data.length; i++) {
          
          LatLng latlng = LatLng(double.parse(data[i]["latitude"].toString()),
          double.parse(data[i]["longitude"].toString()));
          _list.add(Marker(
            markerId: MarkerId(data[i]["id"].toString()),
            position: latlng,
            infoWindow: InfoWindow(title: data[i]["name"].toString(),),
            icon: await MarkerIcon.downloadResizePictureCircle(
                  'http://192.168.0.117:8000/profiles/${data[i]["profile_pic"]}?v=${DateTime.now().millisecondsSinceEpoch}',
                  size: 150,
                  addBorder: true,
                  borderColor: Colors.white,
                  borderSize: 15),
          ));
          print("hes${data[i]["latitude"]}");
          print("hes${data[i]["longitude"]}");
          print("hes$_list");
        }
      setState(() {
        _loadedPhotos = data;
        // allMarkers=_markers;

        print("a3333333333333${_loadedPhotos[0]["building"]}");
        // for (int i = 0; i < data.length; i++) {
          
        //   LatLng latlng = LatLng(double.parse(data[i]["latitude"].toString()),
        //   double.parse(data[i]["longitude"].toString()));
        //   _list.add(Marker(
        //     markerId: MarkerId(data[i]["id"].toString()),
        //     position: latlng,
        //     infoWindow: InfoWindow(title: data[i]["name"].toString(),),
        //   ));
        //   print("hes${data[i]["latitude"]}");
        //   print("hes${data[i]["longitude"]}");
        //   print("hes$_list");
        // }
        _markers.addAll(_list);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
    _markers.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
          myLocationEnabled: false,
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: const CameraPosition(
            target: LatLng(33.888630, 35.495480),
            zoom: 9.0,
          ),
    );
  }
}
