import 'package:flutter/material.dart';

class PatientPharmacies extends StatefulWidget {
  const PatientPharmacies({ Key? key }) : super(key: key);

  @override
  State<PatientPharmacies> createState() => _PatientPharmaciesState();
}

class _PatientPharmaciesState extends State<PatientPharmacies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phamacies'),
      ),
      body: Center(
        
        child: Column(
          
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[

            Text(
              'Welcome To PharmaConnect!',
            ),
            
            
          ],
        ),
      ),
     
    );
  }
}