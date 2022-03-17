import 'package:flutter/material.dart';

class PatientOrPharmacy extends StatelessWidget {
  const PatientOrPharmacy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To PharmaConnect!'),
      ),
      body: Center(

        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('assets/images/signup.png'),


            ElevatedButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientOrPharmacy()),
            );

            }, child:  const Text('Sign Up As A Patient'),),

            ElevatedButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientOrPharmacy()),
            );

            }, child:  const Text('Sign Up As A Pharmacy'),),
            
          ],
        ),
      ),
    );
  }
}