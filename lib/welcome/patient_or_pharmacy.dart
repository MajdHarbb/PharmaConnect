import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/signIn_signup/pharmacy_signup.dart';
import '../signIn_signup/patient_signup.dart';

class PatientOrPharmacy extends StatelessWidget {
  const PatientOrPharmacy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up!'),
      ),
      body: Center(

        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('assets/images/signup.png'),


            ElevatedButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientSignIn()),
            );

            }, child:  const Text('Sign Up As A Patient'),),

            ElevatedButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PharmacySignUp()),
            );

            }, child:  const Text('Sign Up As A Pharmacy'),),
            
          ],
        ),
      ),
    );
  }
}