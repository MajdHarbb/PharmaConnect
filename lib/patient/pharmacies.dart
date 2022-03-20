import 'package:flutter/material.dart';

class PatientPharmacies extends StatefulWidget {
  const PatientPharmacies({ Key? key }) : super(key: key);

  @override
  State<PatientPharmacies> createState() => _PatientPharmaciesState();
}

class _PatientPharmaciesState extends State<PatientPharmacies> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('pharmacies list'),
    );
  }
}