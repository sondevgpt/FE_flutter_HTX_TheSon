import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  // Cập nhật checkLoginStatus để kiểm tra và làm mới token nếu cần
  Future<void> checkLoginStatus() async {
    final accessToken = await StorageService.getAccessToken();
    if (accessToken != null) {
      // Giả sử token còn hợp lệ hoặc thử làm mới nếu cần
      if (await refreshAccessToken()) {
        // Token đã được làm mới, không cần làm gì thêm
      } else {
        _currentUser = null;
        await StorageService.deleteTokens();
      }
    } else {
      _currentUser = null;
      await StorageService.deleteTokens();
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(
    String mailOrPhone,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    final response = await ApiService.login(mailOrPhone, password);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['data']['accessToken'];
      final refreshToken = data['data']['refreshToken'];
      await StorageService.saveTokens(
        accessToken,
        refreshToken,
      ); // Đã lưu cả hai token
      _currentUser = User.fromJson(data['data']['user']);
    }

    _isLoading = false;
    notifyListeners();
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    final response = await ApiService.register(data);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['data']['accessToken'];
      final refreshToken = data['data']['refreshToken'];
      await StorageService.saveTokens(
        accessToken,
        refreshToken,
      ); // Lưu cả hai token
      _currentUser = User.fromJson(data['data']['user']);
    }

    _isLoading = false;
    notifyListeners();
    return jsonDecode(response.body);
  }

Future<bool> refreshAccessToken() async {
  final refreshToken = await StorageService.getRefreshToken();
  if (refreshToken == null) return false;

  try {
    final response = await ApiService.refreshToken(refreshToken);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['data']['accessToken'];
      final newRefreshToken = data['data']['refreshToken'];
      await StorageService.saveTokens(newAccessToken, newRefreshToken);
      return true;
    }
    return false;
  } catch (e) {
    // ignore: avoid_print
    print('Refresh token error: $e');
    return false;
  }
}

  Future<void> logout() async {
    await StorageService.deleteTokens();
    _currentUser = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final response = await ApiService.sendOtp(phone);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await ApiService.verifyOtp(phone, otp);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> resetPassword(
    String phone,
    String newPassword,
    String otp,
  ) async {
    final response = await ApiService.resetPassword(phone, newPassword, otp);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> checkPhone(String phone) async {
    final response = await ApiService.checkPhone(phone);
    return jsonDecode(response.body);
  }

  void updateUserFromResponse(Map<String, dynamic> data) {
    if (_currentUser != null) {
      // Nếu cần cập nhật chỉ tên (username) thì giữ lại các giá trị ban đầu của user
      _currentUser = User(
        id: _currentUser!.id,
        email: _currentUser!.email,
        phone: _currentUser!.phone,
        name: data['username'] ?? _currentUser!.name,
        role: _currentUser!.role,
        isActive: _currentUser!.isActive,
        otp: _currentUser!.otp,
        accountType: _currentUser!.accountType,
        address: _currentUser!.address,
        activityFields: _currentUser!.activityFields,
        operationAreas: _currentUser!.operationAreas,
        createdAt: _currentUser!.createdAt,
        updatedAt: DateTime.now(), // cập nhật thời gian sửa đổi
        userImageAvatar: _currentUser!.userImageAvatar,
      );
      notifyListeners();
    }
  }
}
