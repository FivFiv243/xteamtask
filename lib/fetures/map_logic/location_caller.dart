import 'package:location/location.dart';

dynamic fetchLocation() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  Location location = new Location();
  LocationData currentPosition;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  return currentPosition = await location.getLocation();
}
