import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/home_screen.dart';
import '../../services/auth_service.dart';

class PasswordScreen extends StatefulWidget {
  final String phone;

  const PasswordScreen({super.key, required this.phone});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _passwordController = TextEditingController();
  bool _obscureText = true; // Biến để kiểm soát ẩn/hiện mật khẩu

  Future<void> _login() async {
  final authService = Provider.of<AuthService>(context, listen: false);
  final response = await authService.login(widget.phone, _passwordController.text);

  if (response['data'] != null) {
    // Chuyển đến HomeScreen và xóa toàn bộ stack trước đó
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false, // Xóa toàn bộ stack
    );
  } else {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'] ?? 'Đăng nhập thất bại')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 3, 161, 239)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                  'assets/images/logo.png',
                height: 150,
              ),
              SizedBox(height: 40),
              // TextField cho mật khẩu với biểu tượng mắt
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Mật khẩu của bạn ",
                  hintStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              // Nút Tiếp tục
              authService.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Tiếp tục",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
              SizedBox(height: 10), // Giảm khoảng cách để sát hơn
              // Liên kết Quên mật khẩu
              TextButton(
                onPressed: () {
                  // Thêm logic quên mật khẩu
                },
                child: Text(
                  "Quên mật khẩu?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 40), // Khoảng cách lớn hơn để tách "Tư vấn hỗ trợ"
              // Liên kết Tư vấn hỗ trợ
              TextButton(
                onPressed: () {},
                child: Text(
                  "Tư vấn hỗ trợ",
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}