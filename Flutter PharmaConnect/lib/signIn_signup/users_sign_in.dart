import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/patient/patient_main.dart';
import 'package:pharmaconnectflutter/pharmacy/pharmacy_main.dart';
import 'package:pharmaconnectflutter/signIn_signup/patient_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInUser extends StatefulWidget {
  const SignInUser({Key? key}) : super(key: key);

  @override
  _SignInUserState createState() {
    return _SignInUserState();
  }
}

class _SignInUserState extends State<SignInUser> {
  //controllers to get user data
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25.0),
          child: buildColumn(),
        ),
      ),
    );
  }

  Column buildColumn() {
    //form key to validate form
    final _formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign In with Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 25.00,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  //email regex
              if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!) == false) {
                return 'Please enter a valid email example: ex@ex.com';
              }
              return null;},
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                if (value == null || value.isEmpty) {
                return 'The password should be a minimum of 6 letters and a digit';
                }
              return null;
            },
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                  //if form is valid fetch login api
                  final prefs = await SharedPreferences.getInstance();
                  final response = await http.post(
                    Uri.parse('http://192.168.0.117:8000/api/auth/login'),
                    body: <String, String>{
                      'email': emailController.text,
                      'password': passController.text,
                    },
                  );

                  if (response.statusCode == 200) {
                    // If the server did return a 200 OK response,
                    // then parse the JSON and set user token in shared prefs
                    var responseJsondata = json.decode(response.body);
                    final String userJsonId =(responseJsondata["user"]["id"]).toString();
                    final String userType =(responseJsondata["user"]["user_type"]).toString();
                    await prefs.setString('accesToken', responseJsondata["access_token"]);
                    await prefs.setString('id', userJsonId);
                    await prefs.setString('user_type', userType);
                    final String? action = prefs.getString('accesToken');
                    final String? action2 = prefs.getString('id');
                    final String? action3 = prefs.getString('user_type');
                    print('hiii $action');
                    print('iddddddddddddd from storage $action2');
                    print("user type $action3");
                    if (userType == "patient") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PatientMain()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PharmacyMain()),
                      );
                    }

                    //return Album.fromJson(jsonDecode(response.body));
                  } else if(response.statusCode == 401) {
                   showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Login Failed'),
                      content: const Text('Incorrect email or password'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ));
                  }
                }
                  
                },
                child: const Text('Sign In'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PatientSignUp()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.blue),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
