import 'package:location/location.dart';

dynamic fetchLocation() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = new Location();
  LocationData _currentPosition;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  return _currentPosition = await location.getLocation();
}
