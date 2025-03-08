import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Check permission and request if needed
  Future<bool> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false; // Permission denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false; // Permission permanently denied
    }

    return true; // Permission granted
  }

  /// Get user location (longitude & latitude)
  Future<List<double>>? getUserLocation() async {
    bool hasPermission = await _handlePermission();
    if (!hasPermission) {
      print("Location permission denied.");
      return [];
    }

    Position? position =  await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    return [position.longitude,position.latitude];
  }


}
