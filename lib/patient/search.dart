import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/widgets/expansionTile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import 'dart:async';
import 'dart:convert';

class PatientSearch extends StatefulWidget {
  const PatientSearch({Key? key}) : super(key: key);

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  List<TextEditingController> _controllers = [];
  List _loadedPhotos = [];
  String test = '';
  String user_id = "";
  String access_Token = "";
  String user_name = "";
  String user_email = "";
  String user_phone = "";
  String user_profile_picture = "";
  File? image;
  late String base64_img;
  String imagePath = '';
  String extension = "";

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('My Posts'),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              _controllers.add(new TextEditingController());
              return count != 0
                  ? Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: AssetImage(
                                    'assets/profiles/$user_profile_picture'),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          user_name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          _loadedPhotos[index]["updated_at"]
                                              .substring(
                                                  0,
                                                  _loadedPhotos[index]
                                                          ["updated_at"]
                                                      .indexOf('T')),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        Icon(
                                          Icons.public,
                                          color: Colors.grey[600],
                                          size: 12.0,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          TextFormField(
                            controller: _controllers[index],
                            decoration: InputDecoration.collapsed(
                                hintText: _loadedPhotos[index]["post_text"]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                pickImage();
                              }, // Image tapped
                              child: Image.asset(
                                'assets/posts/${_loadedPhotos[index]["post_pic"]}',
                                width: 600.0,
                                height: 240.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              image != null
                                  ? ClipOval(
                                      child: Image.file(
                                        image!,
                                        height: 50,
                                        width: 50,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: const Text("Tap here"),
                                    ),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(10, 40),
                                  primary: Colors.white,
                                ),

                                onPressed: () {
                                  deletePost(_loadedPhotos[index]["id"]);
                                },
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.black),
                                ),
                                //controller: streetController,
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.save,
                                  color: Colors.blue,
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(10, 40),
                                  primary: Colors.white,
                                ),

                                onPressed: () {
                                  print(_loadedPhotos[index]["id"]);
                                },
                                label: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.black),
                                ),
                                //controller: streetController,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("You don't have any posts yet"),
                    );
            },
            childCount: _loadedPhotos.length, // 1000 list items
          ),
        ),
      ],
    ));
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      user_id = prefs.getString('id')!;
      user_name = prefs.getString('name')!;
      user_email = prefs.getString('email')!;
      user_profile_picture = prefs.getString('profile_pic')!;
      access_Token = prefs.getString('accesToken')!;
    });
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/my-posts'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
      },
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _loadedPhotos = data;
        count = _loadedPhotos.length;
      });
    } else {
      setState(() {
        _loadedPhotos = ["no posts yet"];
        count = 0;
      });
    }
  }

  deletePost(id) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/delete-post'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'post_id': id.toString(),
      },
    );
    if (response.statusCode == 201) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Your post was deleted successfully'),
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
    }
  }

  @override
  initState() {
    super.initState();
    getStringValuesSF();
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

  Future<void> updateProfilePicture() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/update-profile-picture'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
        'profile_pic': "data:image/$extension;base64,$base64_img",
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Profile Picture Updated!'),
          content: const Text('Press okay to return to your screen'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      print(response.body);
      print("===========> done");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
    }
  }
}
