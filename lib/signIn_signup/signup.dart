import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/auth/login'),
    
    body: <String, String>{
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode != 401) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
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
  const Album({required this.accessToken,required this.expiresIn, required this.tokenType,required this.user});

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
  runApp(const SignUp());
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _controller = TextEditingController();
  
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
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum('user@ojne.com','user123456');
              
            });
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
