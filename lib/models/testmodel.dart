import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/patient_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Album> createAlbum(String email, String password) async {
  final prefs = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('http://192.168.0.117:8000/api/auth/login'),
    body: <String, String>{
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    await prefs.setString('accesToken', response.body);
    final String? action = prefs.getString('accesToken');
    print('hiii $action');

    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class User {
  User({
    required this.id,
    required this.email,
    this.emailVerifiedAt,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String email;
  dynamic emailVerifiedAt;
  String userType;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        userType: json["user_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "user_type": userType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Album {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User user;
  const Album(
      {required this.accessToken,
      required this.expiresIn,
      required this.tokenType,
      required this.user});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      user: User.fromJson(json["user"]),
    );
  }
}

void main() {
  runApp(const SignUptest());
}

class SignUptest extends StatefulWidget {
  const SignUptest({Key? key}) : super(key: key);

  @override
  _SignUptestState createState() {
    return _SignUptestState();
  }
}

class _SignUptestState extends State<SignUptest> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child:
                (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter Email here'),
          controller: emailController,
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter password here'),
          controller: passController,
        ),
        ElevatedButton(
          onPressed: () async {
            //   setState(() {
            //     _futureAlbum = createAlbum(emailController.text, passController.text);

            //   Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const PatientMain()),
            // );
            //     // Save an integer value to 'counter' key.

            //   });
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
                  MaterialPageRoute(builder: (context) => const PatientMain()),
                );
              } else {
                print("pharmacy user type page");
              }

              //return Album.fromJson(jsonDecode(response.body));
            } else {
              // If the server did not return a 201 CREATED response,
              // then throw an exception.
              throw Exception('Failed to create album.');
            }
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, data) {
        if (data.hasData) {
          return Text(data.data!.accessToken);
        } else if (data.hasError) {
          return Text('${data.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
