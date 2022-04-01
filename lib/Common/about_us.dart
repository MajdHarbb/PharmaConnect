import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({ Key? key }) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
    Set<Marker> _markers = {};
    double test =32.195476;
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
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: 
            GoogleMap(
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