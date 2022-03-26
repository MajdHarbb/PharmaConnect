import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/models/testmodel.dart';
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
                Image.asset('assets/images/signup.png'),
                ElevatedButton(
                  onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PatientOrPharmacy()),
                  
                );

                }, child:  const Text('Sign In'),
                autofocus: true,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 40),
                ),
                ),

                ElevatedButton(onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUptest()),
                );

                }, child:  const Text('Sign Up'),
                autofocus: true,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 40),
                ),),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}