import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../utility/constants.dart';

class HttpService {
  final String baseUrl = MAIN_URL;

  Future<Response> getItems({required String endpointUrl}) async {
    try {
      final connect = GetConnect(timeout: const Duration(seconds: 10));
      return await connect.get('$baseUrl/$endpointUrl').timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('request timed out');
        },
      );
    } on TimeoutException {
      throw TimeoutException('request timed out');
    } on Exception catch (e) {
      return Response(
          body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> addItem(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      final connect = GetConnect(timeout: const Duration(seconds: 10));
      final response =
          await connect.post('$baseUrl/$endpointUrl', itemData).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('request timed out');
        },
      );
      if (kDebugMode) {
        print(response.body);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> updateItem(
      {required String endpointUrl,
      required String itemId,
      required dynamic itemData}) async {
    try {
      final connect = GetConnect(timeout: const Duration(seconds: 10));
      return await connect
          .put('$baseUrl/$endpointUrl/$itemId', itemData)
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('request timed out');
        },
      );
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> deleteItem(
      {required String endpointUrl, required String itemId}) async {
    try {
      final connect = GetConnect(timeout: const Duration(seconds: 10));
      return await connect.delete('$baseUrl/$endpointUrl/$itemId').timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('request timed out');
        },
      );
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> filterProduct(
      {required String endpointUrl, required dynamic key}) async {
    try {
      if (kDebugMode) {
        print('$baseUrl/$endpointUrl');
      }
      final payload = {'name': key};
      final connect = GetConnect(timeout: const Duration(seconds: 10));
      return await connect.post('$baseUrl/$endpointUrl', payload).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('request timed out');
        },
      );
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }
}
