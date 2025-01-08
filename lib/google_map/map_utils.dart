import 'package:url_launcher/url_launcher.dart';

class MapUtils {  
  MapUtils._();

  // static Future<void> openMap(double latitude, double longitude) async {
  //   String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

  //   if (await canLaunch(googleMapUrl)) {
  //     await launch(googleMapUrl);
  //   } else {  
  //     throw 'Could not open the Map';
  //   }
  // }

  static Future<void> openMap(double latitude, double longitude) async {
  //String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent('$latitude,$longitude')}";

  try {
    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      throw 'Could not launch $googleMapUrl';
    }
  } catch (e) {
    print('Error opening map: $e');
  }
  
}

}
