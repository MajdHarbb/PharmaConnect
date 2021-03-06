import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/patient/PateintNotifications.dart';
import 'package:pharmaconnectflutter/patient/patient_main.dart';
import 'package:pharmaconnectflutter/pharmacy/notifications.dart';
import 'package:pharmaconnectflutter/patient/home.dart';
import 'package:pharmaconnectflutter/patient/pharmacies.dart';
import 'package:pharmaconnectflutter/patient/profile.dart';
import 'package:pharmaconnectflutter/patient/Activity.dart';
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
    //create separate routes in order to keep the bottom navbar outside its main pages
    late Widget child ;
    if(tabItem == "PatientHome") {
      child = const PatientHome();
    } else if(tabItem == "PharmacyHome") {
      child = const PharmacyHome();
    }
    else if(tabItem == "PatientPharmacies") {
      child = const PatientPharmacies();
    } else if(tabItem == "PatientActivity") {
      child = const PatientActivity();
    } else if(tabItem == "Notifications") {
      child = const Notifications();
    } else if(tabItem == "PatientProfile") {
      child = const PatientProfile();
    }else if(tabItem == "PateintNotifications") {
      child = const PateintNotifications();
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