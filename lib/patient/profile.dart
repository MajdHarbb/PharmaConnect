import 'package:flutter/material.dart';
class PatientProfile extends StatefulWidget {
  const PatientProfile({ Key? key }) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
    );
  }
}