import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:pharmaconnectflutter/pharmacy/home.dart';
import 'package:pharmaconnectflutter/pharmacy/profile.dart';

class PharmacyMain extends StatefulWidget {
  const PharmacyMain({ Key? key }) : super(key: key);

  @override
  State<PharmacyMain> createState() => _PharmacyMainState();
}

class _PharmacyMainState extends State<PharmacyMain> {
  int currentIndex = 0;

  final pharmacyScreens = [
    const PharmacyHome(),
    const PharmacyProfile(),
    const PharmacyProfile(),
    const PharmacyProfile(),

    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
      IndexedStack(
        index: currentIndex,
        children: pharmacyScreens
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
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}