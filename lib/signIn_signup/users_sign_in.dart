import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/patient/home.dart';
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
  final TextEditingController _controller = TextEditingController();
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
                  
                  final prefs = await SharedPreferences.getInstance();
                  final response = await http.post(
                    Uri.parse('http://192.168.0.117:8000/api/auth/login'),
                    body: <String, String>{
                      'email': emailController.text,
                      'password': passController.text,
                    },
                  );

                  if (response.statusCode == 200) {
                    // If the server did return a 201 CREATED response,
                    // then parse the JSON.
                    var response_jsondata = json.decode(response.body);
                    print("======================>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    print(response_jsondata["user"]["id"]);
                    //var user_json_id = json.decode(response_jsondata);
                    final String userJsonId =
                        (response_jsondata["user"]["id"]).toString();
                    final String user_type =
                        (response_jsondata["user"]["user_type"]).toString();
                    print(
                        "user iddddddddddddddddddddd ===================>>>>>>>>>>");
                    print(userJsonId);
                    print(user_type);
                    print("======================>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    print(response.body);

                    await prefs.setString(
                        'accesToken', response_jsondata["access_token"]);
                    await prefs.setString('id', userJsonId);
                    await prefs.setString('user_type', user_type);
                    final String? action = prefs.getString('accesToken');
                    final String? action2 = prefs.getString('id');
                    final String? action3 = prefs.getString('user_type');
                    print('hiii $action');
                    print('iddddddddddddd from storage $action2');
                    print("user type $action3");
                    if (user_type == "patient") {
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
