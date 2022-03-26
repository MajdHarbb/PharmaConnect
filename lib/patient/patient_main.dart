import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/browse.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/pharmacies.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:pharmaconnectflutter/patient/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmaconnectflutter/patient/tab_navigator.dart';

class PatientMain extends StatefulWidget {
  const PatientMain({Key? key}) : super(key: key);

  @override
  State<PatientMain> createState() => _PatientMainState();
}

class _PatientMainState extends State<PatientMain> {
  String _currentPage = "PatientHome";
  List<String> pageKeys = ["PatientHome", "PatientPharmacies", "PatientSearch", "Browse", "PatientProfile"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "PatientHome": GlobalKey<NavigatorState>(),
    "PatientPharmacies": GlobalKey<NavigatorState>(),
    "PatientSearch": GlobalKey<NavigatorState>(),
    "Browse": GlobalKey<NavigatorState>(),
    "PatientProfile": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

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
    const PatientSearch(),
    const Browse(),
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
        body: Stack(
          children:<Widget>[
            _buildOffstageNavigator("PatientHome"),
            _buildOffstageNavigator("PatientPharmacies"),
            _buildOffstageNavigator("PatientSearch"),
            _buildOffstageNavigator("Browse"),
            _buildOffstageNavigator("PatientProfile"),
          ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) { _selectTab(pageKeys[index], index); },
          currentIndex: _selectedIndex, 
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

