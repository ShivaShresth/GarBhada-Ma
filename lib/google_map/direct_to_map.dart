import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {


  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentLocation;

  late bool servicePermission = false;

  late LocationPermission permission;

  String? address1;

  String _currentAddress = "";

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placesmarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placesmarks[0];
      Placemark placemark = placesmarks.first;
      String address =
          "${placemark.name}, ${placemark.locality}, ${placemark.country}";

      setState(() {
        _currentAddress = "${place.locality},${place.country}";
        address1 = address;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Launcher Example'),
      ),
      body: Column(
        children: [
          Text("${_currentLocation?.latitude}"),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                _currentLocation = await _getCurrentLocation();
                await _getAddressFromCoordinates();
                // _launchMap();
              },
              child: Text('Open Map'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchMap() async {
    // Replace these coordinates with the desired location
    double? latitude = _currentLocation?.latitude;
    double? longitude = _currentLocation?.longitude;
    //   double latitude = 37.7749;
    // double longitude = -122.4194;

    String mapUrl = 'geo:$latitude,$longitude?q=$latitude,$longitude';

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }
}
