import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PatientHome extends StatefulWidget {
  const PatientHome({ Key? key }) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {


  int currentIndex = 0;

  final screens = [
    const PatientProfile(),
    const PatientProfile(),
    const PatientProfile(),
    const PatientProfile(),

    
  ];

  String test = '';
  String user_id ="";
  String user_type = "";
  
  getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? stringValue = prefs.getString('accesToken');
  user_id = prefs.getString('id')!;
  user_type = prefs.getString('user_type')!;
  print(user_id);
  print(user_type);
  // String? stringValue = prefs.getString('accesToken');
  
  
  // test = stringValue!;

  // const start = 'id":';
  // const end = ",";
  // final startIndex = test.indexOf(start);
  // final endIndex = test.indexOf(end, startIndex + start.length);

  // user_id = test.substring(startIndex + start.length, endIndex);

  // print("user id : $user_id");
  // await prefs.setString('user_id', user_id);
  // String? user_id_fromSP = prefs.getString('user_id');
  // print("from shared $user_id_fromSP");
  // //print(test.substring(startIndex + start.length, endIndex));
  // print(stringValue);
  //return stringValue;
}

  @override
  Widget build(BuildContext context) {
    getStringValuesSF();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To PharmaConnect!'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // const Text(
            //   'Welcome To PharmaConnect!',
            // ),
            Text(user_id),
            Text(user_type),
            
            
            
          ],
        ),
      ),
    //  bottomNavigationBar: BottomNavigationBar(
    //    type: BottomNavigationBarType.fixed,
    //    currentIndex: currentIndex,
    //    onTap: (index) => setState(()=> currentIndex = index),
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //         backgroundColor: Colors.red,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.business),
    //         label: 'Business',
    //         backgroundColor: Colors.green,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.school),
    //         label: 'School',
    //         backgroundColor: Colors.purple,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings),
    //         label: 'Settings',
    //         backgroundColor: Colors.pink,
    //       ),
    //     ],
    //     selectedItemColor: Colors.amber[800],
    //   ),
    );
  }
}

