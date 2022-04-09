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
  File? image;
  late String base64_img;
  String imagePath = '';
  int count = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  TextEditingController postTextController = TextEditingController();
  String test = 'hiii';
  String user_id = "";
  String user_type = "";
  String access_Token = "";
  String extension = "";
  String user_name = "";
  String user_email = "";
  String user_phone = "";
  String user_profile_picture = "";
  String profiletest = "33.jpeg";
  Future<void> AddPost() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/addPost'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
        'post_text': postTextController.text,
        'post_pic': "data:image/$extension;base64,$base64_img",
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print(response.body);
      print("===========> done");
      image = null;
      postTextController = TextEditingController();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:
              const Text('Posted! You will get a reply soon from a pharmacy.'),
          content: const Text('Press okay to return to your screen'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      getStringValuesSF();
      setState(() {});
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
    }
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
      var response_jsondata = json.decode(response.body);
      print("here ======================>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(response_jsondata);
      //var user_json_id = json.decode(response_jsondata);
      final String nameJson = (response_jsondata["user"][0]["name"]).toString();
      final String emailJson =
          (response_jsondata["user"][0]["email"]).toString();
      final String phoneJson =
          (response_jsondata["user"][0]["phone"]).toString();
      final String profileJson =
          (response_jsondata["user"][0]["profile_pic"]).toString();
      print("user iddddddddddddddddddddd ===================>>>>>>>>>>");
      print(nameJson);
      print(emailJson);

      print(phoneJson);
      print(profileJson);
      print("======================>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(response.body);

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

  List _loadedPhotos = [];

  int currentIndex = 0;

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      user_id = prefs.getString('id')!;
      user_type = prefs.getString('user_type')!;
      access_Token = prefs.getString('accesToken')!;
    });
    const API_URL = 'http://192.168.0.117:8000/api/user/post-pharmacies';

    final response = await http.get(
      Uri.parse(API_URL),
      headers: {
        'Authorization': 'Bearer $access_Token',
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
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello $user_name!'),
          leading: const Icon(Icons.home_rounded,),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PharmaciesMap()),
            );
          },
          tooltip: 'Go To Map',
          child: const Icon(Icons.map),
        ),
        body: const Center(
          child: PharmaciesMap(),
        ));
  }

  @override
  initState() {
    super.initState();
    getStringValuesSF();
    getUserInfo();
  }

}
