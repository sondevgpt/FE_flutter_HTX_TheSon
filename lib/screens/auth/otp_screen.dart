import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

  Future<void> _verifyOtp() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final response = await authService.verifyOtp(widget.phone, _otpController.text);

    if (response['isValid'] == true) {
      // Chuyển đến màn hình nhập thông tin đăng ký (chưa có, bạn cần tạo)
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xác thực OTP thành công')),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Xác thực OTP thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', height: 150),
                SizedBox(height: 20),
                Text(
                  "Nhập mã xác minh",
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Nhập mã OTP đã được gửi qua số điện thoại 0****678 đã bạn",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Mã OTP *",
                    hintStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 20),
                authService.isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Tiếp tục", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Gọi lại sendOtp nếu cần
                    final authService = Provider.of<AuthService>(context, listen: false);
                    authService.sendOtp(widget.phone);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gửi lại OTP thành công')),
                    );
                  },
                  child: Text("Không nhận được mã? Gửi lại mã", style: TextStyle(color: Colors.blue)),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: Text("Tư vấn hỗ trợ", style: TextStyle(color: Colors.blue, fontSize: 12)),
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
    _otpController.dispose();
    super.dispose();
  }
}