import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/browse.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/pharmacies.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:pharmaconnectflutter/patient/search.dart';

class PatientMain extends StatefulWidget {
  const PatientMain({ Key? key }) : super(key: key);

  @override
  State<PatientMain> createState() => _PatientMainState();
}

class _PatientMainState extends State<PatientMain> {
  int currentIndex = 0;
  
  final screens = [
    const PatientHome(),
    const PatientPharmacies(),
    const PatientSearch(),
    const Browse(),
    const PatientProfile(),

    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
      IndexedStack(
        index: currentIndex,
        children: screens
      ),
      
     bottomNavigationBar: BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
       currentIndex: currentIndex,
       onTap: (index) => setState(()=> currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Pharmacy',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.pink,
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}