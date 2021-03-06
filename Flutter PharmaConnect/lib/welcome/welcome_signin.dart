import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/signIn_signup/users_sign_in.dart';
import 'package:pharmaconnectflutter/welcome/patient_or_pharmacy.dart';

class WelcomeSignIn extends StatelessWidget {
  const WelcomeSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Welcome To PharmaConnect',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                Image.network(
                    'http://192.168.0.117:8000/images/caringedit2.png'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PatientOrPharmacy()),
                    );
                  },
                  child: const Text('Sign Up'),
                  autofocus: true,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(240, 40),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInUser()),
                    );
                  },
                  child: const Text('Sign In'),
                  autofocus: true,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(240, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
