import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Expansiontile extends StatefulWidget {
  const Expansiontile({Key? key}) : super(key: key);

  @override
  State<Expansiontile> createState() => _ExpansiontileState();
}

class _ExpansiontileState extends State<Expansiontile> {
  late String user_id = "";
  String user_type = "";
  String access_Token = "";
  String extension = "";
  String user_name = "";
  String user_email = "";
  String user_phone = "";
  String user_profile_picture = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  final TextEditingController newpassContoller = TextEditingController();
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
    print(
        "hello =========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>;d");
    getStringValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Column(
                  children: [
                    Row(children: [
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
                              "Edit Name",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Enter Your Name here: ",
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
                    ]),
                  ],
                ),
                children: [
                  ListTile(
                    title: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.text_fields_rounded),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter your new name"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                      ),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter your password"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passConfirmController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                      ),
                                      hintText: "Confirm your password"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (nameController.text == "" ||
                                        passController.text == "" ||
                                        passConfirmController.text == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              'You are entering empty values!'),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () {
                                              // Code to execute.
                                            },
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (passController.text !=
                                          passConfirmController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Passwords did not match!'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Code to execute.
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        updateName();
                                      }
                                    }
                                  },
                                  child: Text('save')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ExpansionTile(
                title: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.phone_android_rounded,
                        color: Colors.grey[600],
                        size: 30.0,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Edit Phone",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Enter Your Phone here: ",
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
                    ]),
                  ],
                ),
                children: [
                  ListTile(
                    title: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.phone_android_rounded),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter your new phone number"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                      ),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter your password"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passConfirmController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                      ),
                                      hintText: "Confirm your password"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (phoneController.text == "" ||
                                        passController.text == "" ||
                                        passConfirmController.text == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              'Enter your phone number and password'),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () {
                                              // Code to execute.
                                            },
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (phoneController.text.length != 8) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Phone number must be 8 digits only '),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Code to execute.
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                      if (passController.text !=
                                          passConfirmController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Passwords did not match!'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Code to execute.
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        updatePhone();
                                      }
                                    }
                                  },
                                  child: const Text('save')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ExpansionTile(
                title: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.password_rounded,
                        color: Colors.grey[600],
                        size: 30.0,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Edit Password",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Enter Your Password",
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
                    ]),
                  ],
                ),
                children: [
                  ListTile(
                    title: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: newpassContoller,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.text_fields_rounded),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter your new password"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                      ),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter your old password"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passConfirmController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                      ),
                                      hintText: "Confirm your old password"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (newpassContoller.text == "" ||
                                        passController.text == "" ||
                                        passConfirmController.text == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              const Text('Enter your password'),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () {
                                              // Code to execute.
                                            },
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (newpassContoller.text.length <= 8) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Password must be at least 6 characters and include a number'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Code to execute.
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                      if (passController.text !=
                                          passConfirmController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Passwords did not match!'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Code to execute.
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        updatePassword();
                                      }
                                    }
                                  },
                                  child: Text('save')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateName() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/update-name'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
        'name': nameController.text,
        'password': passController.text,
        'password_confirmation': passConfirmController.text,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Name Successfully Updated!'),
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
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Wrong Password!'),
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
    }
  }

  Future<void> updatePhone() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/update-phone'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
        'phone': phoneController.text,
        'password': passController.text,
        'password_confirmation': passConfirmController.text,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Phone Successfully Updated!'),
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
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(response.body),
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
    }
  }

  Future<void> updatePassword() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.117:8000/api/user/update-password'),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
      body: {
        'user_id': user_id,
        'password': passController.text,
        'password_confirmation': passConfirmController.text,
        'new_password': newpassContoller.text,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Password Successfully Updated!'),
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
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(response.body),
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
    }
  }
}
