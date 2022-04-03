import 'package:flutter/material.dart';
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
      // final String? action = prefs.getString('name');
      // final String? action2 = prefs.getString('email');
      // final String? action3 = prefs.getString('phone');
      // final String? action4 = prefs.getString('phone');
      setState(() {
        user_name = prefs.getString('name')!;
        user_email = prefs.getString('email')!;
        user_phone = prefs.getString('phone')!;
        user_profile_picture = prefs.getString('profile_pic')!;
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
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
  //   Future<void> _fetchData() async {

  //   const API_URL = 'http://192.168.0.117:8000/api/user/post-pharmacies';

  //   final response = await http.get(
  //     Uri.parse(API_URL),
  //     headers: {
  //       'Authorization': 'Bearer $access_Token',
  //     },
  //   );
  //   final data = json.decode(response.body);
  //   print(data);

  //   setState(() {
  //     _loadedPhotos = data;
  //   });
  // }

  @override
  initState() {
    super.initState();
    print(
        "hello =========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>;d");
    getStringValuesSF();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    //myPosts();
    //initState();
    // _fetchData();
    print(user_name);
    print(user_id);
    print(user_email);
    print(user_phone);
    print(_loadedPhotos);
    print(user_profile_picture);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello $user_name!'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(children: <Widget>[
                          const Expanded(child: Divider()),
                          Text("Solved Posts: ${_loadedPhotos.length}"),
                          const Expanded(child: Divider()),
                        ])),
                    count != 0
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
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
                                                  Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => SolvedPost(postid: _loadedPhotos[index]["post_id"].toString(),)),
                                                        );
                                                        
                                                      },
                                                      child:  const Text("pharmacies")),
                                                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.blue),
                                                ],
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
                                    Text(_loadedPhotos[index]["post_text"]),
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
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     image != null
                                    //         ? GestureDetector(
                                    //           onTap: () {
                                    //               pickImage();
                                    //             },
                                    //           child: ClipOval(
                                    //               child: Image.file(
                                    //                 image!,
                                    //                 height: 50,
                                    //                 width: 50,
                                    //               ),
                                    //             ),
                                    //         )
                                    //         : GestureDetector(
                                    //             onTap: () {
                                    //               pickImage();
                                    //             },
                                    //             child: const Text("Edit Image"),
                                    //           ),
                                    //     ElevatedButton.icon(
                                    //       icon: const Icon(
                                    //         Icons.delete_rounded,
                                    //         color: Colors.red,
                                    //       ),
                                    //       style: ElevatedButton.styleFrom(
                                    //         minimumSize: const Size(10, 40),
                                    //         primary: Colors.white,
                                    //       ),

                                    //       onPressed: () {
                                    //         deletePost(_loadedPhotos[index]["id"]);
                                    //       },
                                    //       label: const Text(
                                    //         'Delete',
                                    //         style: TextStyle(color: Colors.black),
                                    //       ),
                                    //       //controller: streetController,
                                    //     ),
                                    //     ElevatedButton.icon(
                                    //       icon: const Icon(
                                    //         Icons.save,
                                    //         color: Colors.blue,
                                    //       ),
                                    //       style: ElevatedButton.styleFrom(
                                    //         minimumSize: const Size(10, 40),
                                    //         primary: Colors.white,
                                    //       ),

                                    //       onPressed: () {
                                    //         updatePost(_loadedPhotos[index]["id"],_controllers[index].text);
                                    //       },
                                    //       label: const Text(
                                    //         'Save',
                                    //         style: TextStyle(color: Colors.black),
                                    //       ),
                                    //       //controller: streetController,
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              );
                            },
                            itemCount: _loadedPhotos.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            scrollDirection: Axis.vertical,
                          )
                        : Column(
                            children: [
                              const Text(
                                  "You don't have any posts yet, create a post"),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Get Statred ",
                                    style: TextStyle(fontSize: 50.0),
                                  ),
                                  //Image.asset("assets/images/Demo.gif")
                                ],
                              )
                            ],
                          ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
