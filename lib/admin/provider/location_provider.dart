

// ignore_for_file: use_build_context_synchronously

import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier{

  late String address;
  Placemark placemark= Placemark();

bool isLoading=false;

  Future<void> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      kShowMyDialog(
        context: context,
        body: "Please enable location services to use this feature.",
        onPressed: () async {
          bool locationEnabled = await Geolocator.openLocationSettings();
          if (locationEnabled) {
            print("Location services are enabled");
            Navigator.of(context).pop();
          }
        },);
      print("Location Services are disabled");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission=await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location Permissions are denied");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      kShowMyDialog(
        context: context,
        body:
        "Please allow Location permissions from app permission",
        onPressed: () async {
          await Geolocator.openAppSettings();
          Navigator.of(context).pop(); // Close the dialog.
        },
      );
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    await getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    GetAddressFromLatLong(position);
    double lat = position.latitude;
    double long = position.longitude;
    print("Latitude: $lat and Longitude: $long");
  }


  Future<void> GetAddressFromLatLong(Position position) async {
    isLoading =true;
    notifyListeners();
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    placemark = placemarks[0];
    address =
    '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country} ,${placemark.postalCode}';
    print(address);

    isLoading =false;
  notifyListeners();
  }



}