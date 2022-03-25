import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude,) async {
    String googleMapUrl = "https://www.gooogle.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await canLaunch(googleMapUrl)){
      await launch(googleMapUrl);
    }else{
      throw 'Unable to open map';
    }
  }
}