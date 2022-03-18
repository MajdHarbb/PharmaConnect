import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/models/testmodel.dart';

class PatientSignIn extends StatefulWidget {
  const PatientSignIn({Key? key}) : super(key: key);

  @override
  State<PatientSignIn> createState() => _PatientSignInState();
}

class _PatientSignInState extends State<PatientSignIn> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();

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
