import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import '../api_services.dart';
import '../models/booking_model.dart';

class BookingProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final _storage = GetStorage();
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _storage.hasData('token');

  Future<void> fetchBookings() async {
    if (!isAuthenticated) {
      _error = 'Please login to view bookings';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.getBookings();
      _bookings = (response as List)
          .map((booking) => Booking.fromJson(booking))
          .toList();
      _error = null;
    } catch (e) {
      if (kDebugMode) {
        print('Error in booking provider: $e');
      }
      _error = e.toString();
      _bookings = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    if (!isAuthenticated) {
      _error = 'Please login to create a booking';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      await _apiService.createBooking(bookingData);
      await fetchBookings(); // Refresh the list after creating
    } catch (e) {
      if (kDebugMode) {
        print('Error in booking provider: $e');
      }
      _error = e.toString();
      notifyListeners();
      _isLoading = false;
      notifyListeners();
      throw Future.error(e.toString());

    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
