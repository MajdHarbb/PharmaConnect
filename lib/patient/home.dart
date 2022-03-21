import 'package:flutter/material.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  String test = '';
  String user_id = "";
  String user_type = "";
  String access_Token = "";
  String extension= "";

  Future<void> AddPost() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/addPost'),
      headers : { 'Authorization': 'Bearer $access_Token',},
      body: {
        'user_id': user_id,
        'post_text': "emailController.text",
        'post_pic': "data:image/$extension;base64,$base64_img",
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print(response.body);
      print("===========> done");
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

  List _loadedPhotos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const API_URL = 'https://jsonplaceholder.typicode.com/photos';

    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);
    print("==============> albums");
    // setState(() {
    //   _loadedPhotos = data;
    // });
  }

  int currentIndex = 0;

  final screens = [
    const PatientProfile(),
    const PatientProfile(),
    const PatientProfile(),
    const PatientProfile(),
  ];

  

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      user_id = prefs.getString('id')!;
      user_type = prefs.getString('user_type')!;
      access_Token = prefs.getString('accesToken')!;
    });

    print(user_id);
    print(user_type);
    // String? stringValue = prefs.getString('accesToken');

    // test = stringValue!;

    // const start = 'id":';
    // const end = ",";
    // final startIndex = test.indexOf(start);
    // final endIndex = test.indexOf(end, startIndex + start.length);

    // user_id = test.substring(startIndex + start.length, endIndex);

    // print("user id : $user_id");
    // await prefs.setString('user_id', user_id);
    // String? user_id_fromSP = prefs.getString('user_id');
    // print("from shared $user_id_fromSP");
    // //print(test.substring(startIndex + start.length, endIndex));
    // print(stringValue);
    //return stringValue;
  }

  @override
  initState() {
    super.initState();
    print(
        "hello =========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>;d");
    getStringValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    //initState();
    // _fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Patient'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // const Text(
            //   'Welcome To PharmaConnect!',
            // ),
            Text(user_id),
            Text(user_type),
            Text(access_Token),
            Container(
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.grey[200],
                          //backgroundImage: NetworkImage("assets\images\test.jpg"),
                        ),
                        const SizedBox(width: 8.0),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: "What's on your mind?"),
                          ),
                        ),
                      ]),
                  const Divider(height: 10.0, thickness: 0.1),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                            child: TextButton.icon(
                              onPressed: pickImage,
                              label: const Text('Add Image'),
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: AddPost,
                          label: const Text('Post'),
                          icon: const Icon(
                            Icons.send,
                            color: Colors.red,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
