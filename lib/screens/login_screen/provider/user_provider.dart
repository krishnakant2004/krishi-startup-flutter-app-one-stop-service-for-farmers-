import 'dart:developer';

import 'package:flutter_login/flutter_login.dart';
import 'dart:async';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/user.dart';
import '../../../utility/snack_bar_helper.dart';
import '../login_screen.dart';
import '../../../services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utility/constants.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  TextEditingController userNameController = TextEditingController();
  TextEditingController buisnessNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final DataProvider _dataProvider;
  final box = GetStorage();

  UserProvider(this._dataProvider);

  Future<String?> login(Map<String, dynamic> loginData) async {
    try {
      final response = await service.addItem(
          endpointUrl: 'users/login', itemData: loginData);

      if (response.statusCode == 408) {
        throw TimeoutException(
            response.body?['message'] ?? 'Connection timeout');
      }

      if (response.isOk) {
        final ApiResponse<User> apiResponse = ApiResponse<User>.fromJson(
            response.body,
            (json) => User.fromJson(json as Map<String, dynamic>));
        if (apiResponse.success == true) {
          User? user = apiResponse.data;
          saveLoginInfo(user);
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Login success');
          return 'true';
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Login: ${apiResponse.message}');
          return 'Failed to Login';
        }
      } else {
        final errorMessage =
            'Error ${response.body?['message'] ?? response.statusText}';
        SnackBarHelper.showErrorSnackBar(errorMessage);
        return errorMessage;
      }
    } on TimeoutException catch (e) {
      final message =
          'Connection timeout. Please check your internet connection.';
      SnackBarHelper.showErrorSnackBar(message);
      return message;
    } catch (e) {
      print(e);
      final message =  'Connection timeout. Please try again.';
      SnackBarHelper.showErrorSnackBar(message);
      return message;
    }
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    try {
      final response = await service.addItem(
          endpointUrl: 'users/register', itemData: userData);
      print(response.statusCode);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Register Success');
          return true;
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Register: ${apiResponse.message}');
          return false;
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
        return false;
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      return false;
    }
  }

  Future<void> saveLoginInfo(User? loginUser) async {
    await box.write(USER_INFO_BOX, loginUser?.toJson());
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
  }

  User? getLoginUsr() {
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
    User? userLogged = User.fromJson(userJson ?? {});
    return userLogged;
  }

  logOutUser() {
    box.remove(USER_INFO_BOX);
    Get.offAll(const LoginScreen());
  }

  clearFields() {
    userNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneNumberController.clear();
    buisnessNameController.clear();
  }
}
