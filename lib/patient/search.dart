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
  TextEditingController postTextController = TextEditingController();

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
        appBar: AppBar(
          title: const Text('My Activity'),
          leading: const Icon(
            Icons.bar_chart_rounded,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(7),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: NetworkImage(
                                'http://192.168.0.117:8000/profiles/$user_profile_picture'),
                            //  AssetImage('assets/profiles/$user_profile_picture'),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextFormField(
                              controller: postTextController,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Find your medicine, $user_name"),
                            ),
                          ),
                        ]),
                    const Divider(height: 10.0, thickness: 0.1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: image != null
                                  ? ClipOval(
                                      child: Image.file(
                                        image!,
                                        height: 50,
                                        width: 50,
                                      ),
                                    )
                                  : const Text(
                                      'No image selected yet',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
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
                          TextButton(
                            onPressed: AddPost,
                            child: const Text('Post'),
                          ),
                          const Icon(
                            Icons.send_rounded,
                            color: Colors.blue,
                          ),
                        ]),
                  ],
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    count != 0
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext, index) {
                              _controllers.add(new TextEditingController());
                              return Container(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundColor: Colors.grey[200],
                                          backgroundImage: NetworkImage(
                                              'http://192.168.0.117:8000/profiles/$user_profile_picture'),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    user_name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _loadedPhotos[index]
                                                            ["updated_at"]
                                                        .substring(
                                                            0,
                                                            _loadedPhotos[index]
                                                                    [
                                                                    "updated_at"]
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
                                          hintText: _loadedPhotos[index]
                                              ["post_text"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          pickImage();
                                        }, // Image tapped
                                        child: Image.network(
                                          'http://192.168.0.117:8000/posts/${_loadedPhotos[index]["post_pic"]}?v=${DateTime.now().millisecondsSinceEpoch}',
                                          width: 600.0,
                                          height: 240.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        image != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  pickImage();
                                                },
                                                child: ClipOval(
                                                  child: Image.file(
                                                    image!,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  pickImage();
                                                },
                                                child: const Text("Edit Image"),
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
                                            deletePost(
                                                _loadedPhotos[index]["id"]);
                                          },
                                          label: const Text(
                                            'Delete',
                                            style:
                                                TextStyle(color: Colors.black),
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
                                            updatePost(
                                                _loadedPhotos[index]["id"],
                                                _controllers[index].text);
                                          },
                                          label: const Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //controller: streetController,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: _loadedPhotos.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            scrollDirection: Axis.vertical,
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
                            child: const Text(
                                "You don't have any notifications yet, please wait for a reply"),
                          ),
                  ]),
            ],
          ),
        ));
  }

  Future<void> getStringValuesSF() async {
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

  Future<void> updatePost(id, post_text) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/update-post'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'post_id': id.toString(),
        'post_text': post_text,
        'post_pic': "data:image/$extension;base64,$base64_img",
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      getStringValuesSF();
      setState(() {});
      _controllers.length = 0;
      image = null;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Post Updated!'),
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
}
