import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/models/testmodel.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PatientSignIn extends StatefulWidget {
  const PatientSignIn({Key? key}) : super(key: key);

  @override
  State<PatientSignIn> createState() => _PatientSignInState();
}

class _PatientSignInState extends State<PatientSignIn> {

  File? image;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();


  Future pickImage() async{
    try {
      final image =await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        print('fetched!');
      });
    } on Exception catch (e) {
      print('Failed to capture image: $e');
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Sign Up!'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                   Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: image != null ? ClipOval(
                        child: Image.file(image!,
                        height:50 , width: 50,),
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

                        onPressed: () {pickImage();},
                        label: const Text(
                          'Pick Image',
                          style: TextStyle(color: Colors.black),
                        ),
                        //controller: streetController,
                      ),
                    ),
                  ),

                  
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse('http://192.168.0.117:8000/api/auth/register'),
                    body: <String, String>{
                      'name': nameController.text,
                      'email': emailController.text,
                      'phone': phoneController.text,
                      'password': passController.text,
                      'password_confirmation': passConfirmController.text,
                      'profile_pic': 'profile pic test',
                      'user_type': 'patient',
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
}
