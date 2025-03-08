import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import '../api_services.dart';
import '../models/machinary_model.dart';


class MachineryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final _storage = GetStorage();
  List<Machinery> _machineryList = [];
  List<Machinery> _filteredMachinary = [];
  bool _isLoading = false;
  Machinery? _selectedMachinery;
  String? _error;

  List<Machinery> get machineryList => _machineryList;
  List<Machinery> get filteredMachinary => _filteredMachinary;
  bool get isLoading => _isLoading;
  Machinery? get selectedMachinery => _selectedMachinery;
  String? get error => _error;
  bool get isAuthenticated => _storage.hasData('token');

  Future<void> fetchMachineryList() async {
    if (!isAuthenticated) {
      _error = 'Please login to view machinery';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.getMachinery();
      _machineryList =response;
      _filteredMachinary = _machineryList;
      _error = null;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching machinery: $e');
      }
      _error = e.toString();
      _machineryList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createMachinery(Map<String, dynamic> machineryData) async {
    if (!isAuthenticated) {
      _error = 'Please login to add machinery';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      if (kDebugMode) {
        print('Creating machinery with data:');
        print(machineryData);
      }

      final response = await _apiService.createMachinery(machineryData);
      final newMachinery = Machinery.fromJson(response);
      _machineryList.add(newMachinery);
      _filteredMachinary.add(newMachinery);
      _error = null;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating machinery: $e');
      }
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectMachinery(Machinery machinery) {
    _selectedMachinery = machinery;
    notifyListeners();
  }

  void searchMachinery(String query) {
    if (query.isEmpty) {
      _filteredMachinary = _machineryList;
      return;
    }

    _filteredMachinary =  _machineryList.where((machinery) {
      final searchLower = query.toLowerCase();
      return machinery.name.toLowerCase().contains(searchLower) ||
          machinery.type.toLowerCase().contains(searchLower) ||
          machinery.description.toLowerCase().contains(searchLower);
    }).toList();
    notifyListeners();
  }

  void filterByType(String type) {
    if (type.isEmpty){
      _filteredMachinary = _machineryList;
      return;
    }

    _filteredMachinary =  _machineryList
        .where((machinery) => machinery.type == type)
        .toList();
    notifyListeners();
  }

  List<String> get availableTypes {
    return _machineryList
        .map((machinery) => machinery.type)
        .toSet()
        .toList();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
