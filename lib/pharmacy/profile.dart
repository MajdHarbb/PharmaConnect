import 'package:flutter/material.dart';
class PharmacyProfile extends StatefulWidget {
  const PharmacyProfile({ Key? key }) : super(key: key);

  @override
  State<PharmacyProfile> createState() => _PharmacyProfileState();
}

class _PharmacyProfileState extends State<PharmacyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
    );
  }
}