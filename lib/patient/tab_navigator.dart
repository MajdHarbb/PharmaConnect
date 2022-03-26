import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/patient_main.dart';
import 'package:pharmaconnectflutter/patient/notifications.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/pharmacies.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:pharmaconnectflutter/patient/search.dart';
import 'package:pharmaconnectflutter/pharmacy/home.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    late Widget child ;
    if(tabItem == "PatientHome") {
      child = const PatientHome();
    } else if(tabItem == "PharmacyHome") {
      child = const PharmacyHome();
    }
    else if(tabItem == "PatientPharmacies") {
      child = const PatientPharmacies();
    } else if(tabItem == "PatientSearch") {
      child = const PatientSearch();
    } else if(tabItem == "Notifications") {
      child = const Notifications();
    } else if(tabItem == "PatientProfile") {
      child = const PatientProfile();
    }
    
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child
        );
      },
    );
  }
}