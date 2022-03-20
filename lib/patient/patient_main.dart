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
      
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
          
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[

      //       // const Text(
      //       //   'Welcome To PharmaConnect!',
      //       // ),
      //       Text(test),
            
            
      //     ],
      //   ),
      // ),
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