import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/PateintNotifications.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/pharmacies.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:pharmaconnectflutter/patient/Activity.dart';
import 'package:pharmaconnectflutter/patient/tab_navigator.dart';

class PatientMain extends StatefulWidget {
  const PatientMain({Key? key}) : super(key: key);

  @override
  State<PatientMain> createState() => _PatientMainState();
}

class _PatientMainState extends State<PatientMain> {
  String _currentPage = "PatientHome";
  //list of pages for the patient user type
  List<String> pageKeys = [
    "PatientHome",
    "PatientPharmacies",
    "PatientActivity",
    "PateintNotifications",
    "PatientProfile"
  ];
  //Global keys with pages names
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "PatientHome": GlobalKey<NavigatorState>(),
    "PatientPharmacies": GlobalKey<NavigatorState>(),
    "PatientActivity": GlobalKey<NavigatorState>(),
    "PateintNotifications": GlobalKey<NavigatorState>(),
    "PatientProfile": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;
  //routing each page name to an index
  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  int currentIndex = 0;

  final screens = [
    const PatientHome(),
    const PatientPharmacies(),
    const PatientActivity(),
    const PateintNotifications(),
    const PatientProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "PatientHome") {
            _selectTab("PatientHome", 0);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("PatientHome"),
          _buildOffstageNavigator("PatientPharmacies"),
          _buildOffstageNavigator("PatientActivity"),
          _buildOffstageNavigator("PateintNotifications"),
          _buildOffstageNavigator("PatientProfile"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: 'Pharmacy',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'My Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
