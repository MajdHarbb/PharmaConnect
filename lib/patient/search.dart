import 'package:flutter/material.dart';

class PatientSearch extends StatefulWidget {
  const PatientSearch({ Key? key }) : super(key: key);

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('search'),
    );
  }
}