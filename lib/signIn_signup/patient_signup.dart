import 'package:flutter/material.dart';

class PatientSignIn extends StatefulWidget {
  const PatientSignIn({ Key? key }) : super(key: key);

  @override
  State<PatientSignIn> createState() => _PatientSignInState();
}

class _PatientSignInState extends State<PatientSignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Text('patient'),
    );
  }
}