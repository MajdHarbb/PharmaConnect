import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/signIn_signup/users_sign_in.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PatientSignUp extends StatefulWidget {
  const PatientSignUp({Key? key}) : super(key: key);

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  File? image;
  late String base64_img;
  String imagePath = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Patient Sign Up'),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  const Text(
                      'Sign up with Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                  ),
                ),
                const SizedBox(width: 0, height:30),
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    obscureText: true,
                    controller: passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your password',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    obscureText: true,
                    controller: passConfirmController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your password again',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     Flexible(
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 8),
                //         child: image != null
                //             ? ClipOval(
                //                 child: Image.file(
                //                   image!,
                //                   height: 50,
                //                   width: 50,
                //                 ),
                //               )
                //             : const FlutterLogo(size: 50),
                //       ),
                //     ),
                //     Flexible(
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 8, vertical: 8),
                //         child: ElevatedButton.icon(
                //           icon: const Icon(
                //             Icons.image_outlined,
                //             color: Colors.blue,
                //             size: 24.0,
                //           ),
                //           style: ElevatedButton.styleFrom(
                //             minimumSize: const Size(50, 40),
                //             primary: Colors.white,
                //           ),

                //           onPressed: () {
                //             pickImage();
                //           },
                //           label: const Text(
                //             'Pick Image',
                //             style: TextStyle(color: Colors.black),
                //           ),
                //           //controller: streetController,
                //         ),
                //       ),
                //     ),
                    
                //   ],
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(45),),
                  onPressed: () async {

                    // var request = http.MultipartRequest('POST', Uri.parse('http://192.168.0.117:8000/api/auth/register'));
                    // request.fields['name'] = nameController.text;
                    // request.fields['email'] = emailController.text;
                    // request.fields['phone'] = phoneController.text;
                    // request.fields['password'] = passController.text;
                    // request.fields['password_confirmation'] = passConfirmController.text;
                    // request.fields['user_type'] = 'patient';
                    // request.files.add(await http.MultipartFile.fromPath('profile_pic', imagePath));
                    // var response = await request.send();
                    String defualtImage = r'defualt_profile_picture_pharmaConnect.png';
                    final response = await http.post(
                      Uri.parse('http://192.168.0.117:8000/api/auth/register'),
                      //headers : { 'Content-Type': 'multipart/form-data',},
                      body: {
                        'name': nameController.text,
                        'email': emailController.text,
                        'phone': phoneController.text,
                        'password': passController.text,
                        'password_confirmation': passConfirmController.text,
                        'profile_pic': defualtImage,
                        'user_type': 'patient',
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
                Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            const Text("Already have an account?"), 
            TextButton(onPressed: (){
              Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInUser()),
                      );
            }, child: const Text("Sign In"), ),
            const Icon(Icons.arrow_forward_ios_rounded,color: Colors.blue),
          ],
        )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
