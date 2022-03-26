import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/signIn_signup/users_sign_in.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';

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
  String extension = "";
  File? image;
  late String base64_img;
  String imagePath = '';
  late double lat;
  late double long;
  late String governate = "Beirut";
  late String district = "Beirut";
  late int _user = 2;
  late int _districtIndex = 0;
  var governates = <String>[
    'Akkar',
    'Baalbek',
    'Beirut',
    'Beqaa',
    'Mount Lebanon',
    'Nabatieh',
    'North Governate',
    'South Governate',
  ];

  var districts = <String>["Beirut"];
  var Akkar = <String>["Akkar Halba"];
  var Baalbek = <String>["Baalbek", "Hermel"];
  var Beirut = <String>["Beirut"];
  var Beqaa = <String>["Rashaya", "Western Beqaa", "Zahle"];
  var Nabatieh = <String>["Bint Jbeil", "Hasbaya", "Marjeyoun", "Nabatieh"];
  var MountLebanon = <String>[
    "Byblos",
    "Keserwan",
    "Aley",
    "Baabda",
    "Chouf",
    "Matn"
  ];
  var NorthGovernate = <String>[
    "Batroun",
    "Bsharri",
    "Koura",
    "Miniyeh",
    "Tripoli",
    "Zgharta"
  ];
  var SouthGovernate = <String>["Sidon", "Jezzine", "Tyre"];

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pharmacy Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign In with Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
              ),
            ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 8),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email',
                      prefixIcon: Icon(Icons.email_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your phone number',
                      prefixIcon: Icon(Icons.phone_android_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 8),
                  child: TextFormField(
                    controller: passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your password',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 8),
                  child: TextFormField(
                    controller: passConfirmController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your password again',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric( horizontal:1.0, vertical: 8),
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
                        padding: const EdgeInsets.symmetric(vertical: 8),
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
                        child: Container(
                          width: 170,
                          child: DropdownButton<String>(
                            hint: const Text('Pickup on every'),
                            value: _user == null ? null : governates[_user],
                            items: governates.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _user = governates.indexOf(value!);
                                if (_user == 0) {
                                  districts = Akkar;
                                } else if (_user == 1) {
                                  districts = Baalbek;
                                } else if (_user == 2) {
                                  districts = Beirut;
                                } else if (_user == 3) {
                                  districts = Beqaa;
                                } else if (_user == 4) {
                                  districts = MountLebanon;
                                } else if (_user == 5) {
                                  districts = Nabatieh;
                                } else if (_user == 6) {
                                  districts = NorthGovernate;
                                } else if (_user == 7) {
                                  districts = SouthGovernate;
                                }
                                print(governates[_user]);
                                governate = governates[_user];
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Container(
                          width: 170,
                          child: DropdownButton<String>(
                            hint: const Text('Pickup on every'),
                            value: _districtIndex == null
                                ? null
                                : districts[_districtIndex],
                            items: districts.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _districtIndex = districts.indexOf(value!);

                                print(districts[_districtIndex]);
                                district = districts[_districtIndex];
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: image != null
                            ? ClipOval(
                                child: Image.file(
                                  image!,
                                  height: 50,
                                  width: 50,
                                ),
                              )
                            : const FlutterLogo(size: 50),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.image_outlined,
                            color: Colors.blue,
                            size: 24.0,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            pickImage();
                          },
                          label: const Text(
                            'Add License Image',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                      ),
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
                        'profile_pic': 'defualt_profile_picture_pharmaConnect.png',
                        'user_type': 'pharmacy',
                        'building': buildingController.text,
                        'street': streetController.text,
                        'locality': district,
                        'district': governate,

                        'latitude': lat.toString(),
                        'longitude': long.toString(),
                        'license': "data:image/$extension;base64,$base64_img",
                      },
                    );

                    if (response.statusCode == 201) {
                      // If the server did return a 201 CREATED response,
                      // then parse the JSON.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInUser()),
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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      imagePath = image.path;
      print("---------------------->>>>>>>>-------------------");
      print(image.path);
      print("------------------------>>>>>>>>>>>>>>>>>");
      base64_img = base64Encode(await image.readAsBytes());
      String imageName = image.path.split("/").last;
      extension = p.extension(imageName).substring(1);
      print("extension : $extension");
      print('image name $imageName');
      print("baseeeeee $base64_img");
      setState(() {
        this.image = imageTemporary;
        print("picked $imageTemporary");
      });
    } on Exception catch (e) {
      print('Failed to capture image: $e');
    }
  }
}
