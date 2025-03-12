import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'password_screen.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  bool _isChecking = false;

  Future<void> _checkPhone() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số điện thoại!')),
      );
      return;
    }

    setState(() {
      _isChecking = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final response = await authService.checkPhone(_phoneController.text);

      if (response['data']?['registered'] == true) {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => PasswordScreen(phone: _phoneController.text)),
        );
      } else {
        _showRegisterPopup();
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể kết nối đến server: $e')),
      );
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }

  void _showRegisterPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tài khoản không tồn tại'),
        content: const Text('Bạn có muốn đăng ký không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final authService = Provider.of<AuthService>(context, listen: false);
              try {
                await authService.sendOtp(_phoneController.text);
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => OtpScreen(phone: _phoneController.text)),
                );
              } catch (e) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Không thể gửi OTP: $e')),
                );
              }
            },
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Chào mừng bạn đến với HTX SV",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Đăng nhập để tiếp tục",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Số điện thoại của bạn *",
                    hintStyle: const TextStyle(color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _isChecking || authService.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _checkPhone,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          "Tiếp tục",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                const SizedBox(height: 20),
                const Text(
                  "Khi chọn tiếp tục, bạn đồng ý với\nĐiều khoản sử dụng của HTX SV",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Tư vấn hỗ trợ",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}