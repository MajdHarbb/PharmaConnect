import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/signIn_signup/pharmacy_signup.dart';
import '../signIn_signup/patient_signup.dart';

class PatientOrPharmacy extends StatelessWidget {
  const PatientOrPharmacy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create PharmaConnect Acount'),
      ),
      body: Center(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                    'Are You A Pharmacy Owner Or A Patient?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 1,
                       ),
              ),

              Image.network('http://192.168.0.117:8000/images/signup.png'),


              ElevatedButton(
                onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PatientSignUp()),
              );}, 
              child:  const Text('Sign Up As A Patient'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40),),
              ),

              ElevatedButton(onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PharmacySignUp()),
              );

              }, child:  const Text('Sign Up As A Pharmacy'), style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40),),),
              
            ],
          ),
        ),
      ),
    );
  }
}