import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/auth_service.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static final _client = http.Client();

  static Future<http.Response> _sendRequest({
    required String method,
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    bool isRetry = false, // Thêm flag để tránh lặp vô hạn
  }) async {
    final accessToken = await StorageService.getAccessToken();
    final uri = Uri.parse('$baseUrl$endpoint');

    // ignore: avoid_print
    print('Calling API: $method $uri');
    // ignore: avoid_print
    if (data != null) print('Request Body: ${jsonEncode(data)}');

    final defaultHeaders = {
      'Content-Type': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      ...?headers,
    };

    http.Response response;
    try {
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(uri, headers: defaultHeaders);
          break;
        case 'POST':
          response = await _client.post(
            uri,
            headers: defaultHeaders,
            body: jsonEncode(data),
          );
          break;
        case 'PUT':
          response = await _client.put(
            uri,
            headers: defaultHeaders,
            body: jsonEncode(data),
          );
          break;
        case 'DELETE':
          response = await _client.delete(uri, headers: defaultHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }
    } catch (e) {
      // ignore: avoid_print
      print('API Error: $e');
      rethrow;
    }

    if (response.statusCode == 401 && !isRetry) {
      final authService = Provider.of<AuthService>(
        navigatorKey.currentContext!,
        listen: false,
      );
      if (await authService.refreshAccessToken()) {
        return _sendRequest(
          method: method,
          endpoint: endpoint,
          data: data,
          headers: headers,
          isRetry: true,
        );
      } else {
        authService.logout();
        throw Exception('Token refresh failed, please login again');
      }
    }

    // ignore: avoid_print
    print('API Response: ${response.statusCode} - ${response.body}');
    return response;
  }

  // Auth APIs
  static Future<http.Response> register(Map<String, dynamic> data) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/register',
      data: data,
    );
  }

  static Future<http.Response> login(String phone, String password) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/login',
      data: {'mailOrPhone': phone, 'password': password},
    );
  }
// Thêm phương thức refreshToken
  static Future<http.Response> refreshToken(String refreshToken) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/refresh-token',
      data: {'refreshToken': refreshToken},
    );
  }
  
  static Future<http.Response> sendOtp(String phone) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/send-otp',
      data: {'phone': phone},
    );
  }

  static Future<http.Response> forgotPassword(String phone) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/forgot-password',
      data: {'phone': phone},
    );
  }

  static Future<http.Response> verifyOtp(String phone, String otp) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/verify-otp',
      data: {'phone': phone, 'otp': otp},
    );
  }

  static Future<http.Response> resetPassword(
    String phone,
    String newPassword,
    String otp,
  ) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/reset-password',
      data: {'phone': phone, 'newPassword': newPassword, 'otp': otp},
    );
  }

  static Future<http.Response> checkPhone(String phone) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/auth/check-phone',
      data: {'phone': phone},
    );
  }

  // App APIs (Product & Category)
  static Future<http.Response> getAllCategories() {
    return _sendRequest(method: 'GET', endpoint: '/api/app/category');
  }

  static Future<http.Response> createProduct(Map<String, dynamic> data) {
    return _sendRequest(
      method: 'POST',
      endpoint: '/api/app/product',
      data: data,
    );
  }

  static Future<http.Response> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) {
    return _sendRequest(
      method: 'PUT',
      endpoint: '/api/app/product/$id',
      data: data,
    );
  }

  static Future<http.Response> deleteProduct(String id) {
    return _sendRequest(method: 'DELETE', endpoint: '/api/app/product/$id');
  }

  static Future<http.Response> getProductsByApprovalStatus(String status) {
    return _sendRequest(
      method: 'GET',
      endpoint: '/api/app/product/approval-status?status=$status',
    );
  }

  static Future<http.Response> getAllDisplayedProducts() {
    return _sendRequest(method: 'GET', endpoint: '/api/app/product');
  }

  static Future<http.Response> getProductDetail(String id) {
    return _sendRequest(method: 'GET', endpoint: '/api/app/product/$id');
  }
}
