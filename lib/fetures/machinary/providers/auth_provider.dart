import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import '../api_services.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  final _storage = GetStorage();

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _storage.hasData('token');

  Future<bool> checkAuthStatus() async {
    if (isAuthenticated) {
      try {
        await fetchUserProfile();
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('Auth check failed: $e');
        }
        await logout();
      }
    }
    return false;
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.login(email, password);

      // Make sure we got both token and user data
      if (response['token'] == null || response['user'] == null) {
        throw 'Invalid response from server';
      }

      await _storage.write('token', response['token']);
      _user = User.fromJson(response['user']);

      if (kDebugMode) {
        print('Login successful');
        print('Token: ${_storage.read('token')}');
        print('User: ${_user?.toJson()}');
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      throw e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(Map<String, dynamic> userData) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _apiService.register(userData);
    } catch (e) {
      throw e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      final response = await _apiService.getUserProfile();
      _user = User.fromJson(response);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching profile: $e');
      }
      throw e.toString();
    }
  }

  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.updateUserProfile(profileData);
      _user = User.fromJson(response);

      if (kDebugMode) {
        print('Profile updated successfully');
        print('Updated user data: ${_user?.toJson()}');
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error updating profile: $e');
      }
      throw e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _storage.remove('token');
    _user = null;
    notifyListeners();
  }

  String? getToken() {
    return _storage.read('token');
  }
}
