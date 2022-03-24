import 'package:flutter/material.dart';

class PatientSearch extends StatefulWidget {
  const PatientSearch({ Key? key }) : super(key: key);

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        
        child: Column(
          
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[

            ExpansionTile(
              title: Text('data'), 
            children: [
              ListTile(title: Text('data'),)
            ],
            ),
            
            
          ],
        ),
      ),
     
    );
  }
  
}