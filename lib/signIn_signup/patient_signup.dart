import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/signIn_signup/users_sign_in.dart';


class PatientSignUp extends StatefulWidget {
  const PatientSignUp({Key? key}) : super(key: key);

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  final _formKey = GlobalKey<FormState>(); //form state for form validation

  //controllers to get user input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();

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
          child: Form(
            key: _formKey,
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
                const SizedBox(width: 0, height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!) ==
                          false) {
                        return 'Please enter a valid email example: ex@ex.com';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (RegExp(r"^(?=.*?[0-9]).{8,}$").hasMatch(value!) ==
                          false) {
                        return 'Phone number must be 8 digits';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (RegExp(r"^(?=.*?[a-z])(?=.*?[0-9]).{6,}$")
                              .hasMatch(value!) ==
                          false) {
                        return 'Please must be at least 6 characters including a digit';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if ((value != passController.text)) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: passConfirmController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your password again',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String defualtImage =
                          r'defualt_profile_picture_pharmaConnect.png';
                      final response = await http.post(
                        Uri.parse(
                            'http://192.168.0.117:8000/api/auth/register'),
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
                        // then navigate to sign in page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInUser()),
                        );
                      } else {
                        // If the server did not return a 201 CREATED response,
                        // then print error
                        print(response.body);
                      }
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInUser()),
                        );
                      },
                      child: const Text("Sign In"),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.blue),
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
