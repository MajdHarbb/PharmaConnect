import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/browse.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/pharmacies.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:pharmaconnectflutter/patient/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmaconnectflutter/patient/tab_navigator.dart';
import 'package:pharmaconnectflutter/pharmacy/home.dart';

class PharmacyMain extends StatefulWidget {
  const PharmacyMain({Key? key}) : super(key: key);

  @override
  State<PharmacyMain> createState() => _PharmacyMainState();
}

class _PharmacyMainState extends State<PharmacyMain> {
  String _currentPage = "PharmacyHome";
  List<String> pageKeys = ["PharmacyHome", "Browse", "PatientProfile"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "PharmacyHome": GlobalKey<NavigatorState>(),
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
    const PharmacyHome(),
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
          if (_currentPage != "PharmacyHome") {
            _selectTab("PharmacyHome", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
          child: Scaffold(
        body: Stack(
          children:<Widget>[
            _buildOffstageNavigator("PharmacyHome"),
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

