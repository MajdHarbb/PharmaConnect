import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude,) async {
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await canLaunch(googleMapUrl)){
      await launch(googleMapUrl,forceWebView: true,enableJavaScript: true);
    }else{
      throw 'Unable to open map';
    }
  }
  static Future<void> openDialer(String phone) async {
    String dialerUrl = "tel:$phone";

    if(await canLaunch(dialerUrl)){
      await launch(dialerUrl);
    }else{
      throw 'Unable to open dialer';
    }
  }
}