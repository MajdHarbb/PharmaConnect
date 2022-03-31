
import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/Common/about_us.dart';
import 'package:pharmaconnectflutter/Common/contact_us.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/signIn_signup/users_sign_in.dart';
import 'package:pharmaconnectflutter/user_options/common_functionalities/my_account.dart';
import 'package:pharmaconnectflutter/widgets/alertdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
    late String user_id = "";
    String user_type = "";
    String access_Token = "";
    String extension = "";
    String user_name = "";
    String user_email = "";
    String user_phone = "";
    String user_profile_picture = "";

    File? image;
  late String base64_img;
  String imagePath = '';

    getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');
    print("======== acces $stringValue");
    setState(() {
      user_id = prefs.getString('id')!;
      user_name = prefs.getString('name')!;
      user_email = prefs.getString('email')!;
      user_phone = prefs.getString('phone')!;
      user_profile_picture = prefs.getString('profile_pic')!;
      access_Token = prefs.getString('accesToken')!;
      
    });


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
  @override
  Widget build(BuildContext context) {
    print(user_profile_picture);
    print("==========access");
    print(access_Token);
    print("==============");
    return Scaffold(
      
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(8.0),
          //color: Colors.blue,
          child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
            Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.grey[200],
                          backgroundImage:
                                    AssetImage('assets/profiles/$user_profile_picture'),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:BorderRadius.circular(100)
                          ),
                          child: image != null
                                ? ClipOval(
                                    child: Image.file(
                                      image!,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ) : IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.camera_alt_rounded),
                              onPressed: () {
                                pickImage();
                              },
                            ),
                        )
                      ],
                  ),
                  
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(user_name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "@: $user_email",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.0,
                              ),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(onPressed: (){
                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Please select an image first!'),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                        ),
                      );
                    } else {
                      updateProfilePicture();
                      
                    }
                    
                  }, icon: const Icon(Icons.upload),label: const Text("Upload")),
                  
                ],
              ),
            ),         
            const SizedBox(height: 8.0),
            Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Icon(
                  Icons.person,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Account",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "Edit Your Profile Information",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyAccount()));
                  },
                )
              ]),
            ),
            const SizedBox(height: 8.0),
            Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Logout",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "Logout from the current account",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  onPressed: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const SignInUser()));
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const SignInUser()), (route) => false);

                  },
                )
              ]),
            ),
            const SizedBox(height: 8.0),
            Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "About Us",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "Read more about PharmaConnect",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutUs()));
                  },
                )
              ]),
            ),
            const SizedBox(height: 8.0),
            Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Icon(
                  Icons.message_outlined,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact Us",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "Send us your feedback",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactUs()));
                  },
                )
              ]),
            ),
          ]
                  // color: Colors.blue[100 * (index % 9 + 1)],
                  // height: 80,
                  // alignment: Alignment.center,
                  // child: Text(
                  //   "Item $index",
                  //   style: const TextStyle(fontSize: 30),
                  // ),
                  ),
        ));


  
  }
  
}
