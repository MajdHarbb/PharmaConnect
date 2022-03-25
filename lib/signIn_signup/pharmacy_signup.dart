import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/models/testmodel.dart';

class PharmacySignUp extends StatefulWidget {
  const PharmacySignUp({Key? key}) : super(key: key);

  @override
  State<PharmacySignUp> createState() => _PharmacySignUpState();
}

class _PharmacySignUpState extends State<PharmacySignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  late double lat;
  late double long;
  late int _user =0;
var users = <String>[
  'Bob',
  'Allie',
  'Jason',
];

  static const _initialCameraPoition = CameraPosition(
    target: LatLng(33.833797, 35.544144),
    zoom: 11.5,
    tilt: 50.0,
  );
  late Marker _origin = const Marker(
      markerId: MarkerId('SomeId'),
      position: LatLng(33.833797, 35.544144),
      infoWindow: InfoWindow(title: 'My Current Location'));
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(33.833797, 35.544144),
        infoWindow: InfoWindow(title: 'The title of the marker'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Sign Up!'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your phone number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  controller: passController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  controller: passConfirmController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password again',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: buildingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Buidling',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: streetController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: districtController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'District',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: localityController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Locality',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton<String>(
  hint: new Text('Pickup on every'),
  value: _user == null ? null : users[_user],
  items: users.map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      _user = users.indexOf(value!);
    });
  },
),
                ],
              ),
              SizedBox(
                height: 600.0,
                child: GoogleMap(
                  myLocationButtonEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  initialCameraPosition: _initialCameraPoition,
                  // onMapCreated: (mapController) {
                  //   mapController
                  //       .showMarkerInfoWindow(const MarkerId("origin"));
                  // },

                  //markers: Set<Marker>.of(_markers),
                  markers: {_origin},
                  onLongPress: _addMarker,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse('http://192.168.0.117:8000/api/auth/register'),
                    body: <String, String>{
                      // 'name': nameController.text,
                      // 'email': emailController.text,
                      // 'phone': phoneController.text,
                      // 'password': passController.text,
                      // 'password_confirmation': passConfirmController.text,
                      // 'profile_pic': 'profile pic test',
                      // 'user_type': 'pharmacy',
                      // 'building': buildingController.text,
                      // 'street': streetController.text,
                      // 'district': districtController.text,
                      // 'locality': localityController.text,
                      'name': nameController.text,
                      'email': emailController.text,
                      
                      'password': passController.text,
                      'password_confirmation': passConfirmController.text,
                      'phone': phoneController.text,
                      'profile_pic': 'C:/Users/User/Desktop',
                      'user_type': 'pharmacy',
                      'building': buildingController.text,
                      'street': streetController.text,
                      'locality': localityController.text,
                      'district': districtController.text,
                      
                      'latitude': lat.toString(),
                      'longitude': long.toString(),
                      'license': 'license',
                    },
                  );

                  if (response.statusCode == 201) {
                    // If the server did return a 201 CREATED response,
                    // then parse the JSON.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUptest()),
                    );
                    print(response.body);
                  } else {
                    // If the server did not return a 201 CREATED response,
                    // then throw an exception.
                    print(response.body);
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) {
    setState(() {
      lat = pos.latitude;
      long = pos.longitude;

      String x = lat.toString();
      _origin = Marker(
        markerId: const MarkerId("origin"),
        infoWindow: const InfoWindow(title: "My New Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pos,
      );
      print(pos);
      print(x);
      
    });
  }
}
