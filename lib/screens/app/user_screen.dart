import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';
import '../../widgets/navbar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FF), // Màu nền từ Figma
      body: SafeArea( // Sử dụng SafeArea để tránh khu vực hệ thống
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width, // Chiều rộng phù hợp với màn hình
            decoration: const BoxDecoration(color: Color(0xFFF4F8FF)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header với gradient và thông tin người dùng
                SizedBox(
                  width: double.infinity,
                  height: 164,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 116,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.00, 0.04),
                              end: Alignment(1, -0.04),
                              colors: [Color(0xFF1667E1), Color(0xFF30B4EC)],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 39,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.96),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Stack(
                                        children: [
                                          const Icon(
                                            Icons.notifications,
                                            color: Colors.white,
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 8,
                                              backgroundColor: const Color(0xFFF04437),
                                              child: const Text(
                                                "12",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 100,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 24,
                          height: 64,
                          padding: const EdgeInsets.all(12),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14002A66),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          user?.userImageAvatar ?? "https://placehold.co/72x72",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        user?.name ?? 'Nguyễn Tâm Gia Huy',
                                        style: const TextStyle(
                                          color: Color(0xFF51515B),
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 1.50,
                                        ),
                                      ),
                                      Text(
                                        'ID: ${user?.id ?? 'N/A'}',
                                        style: const TextStyle(
                                          color: Color(0xFFA0A0AA),
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 1.50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xFFA0A0AA),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Nội dung menu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Về 5Sao',
                        style: TextStyle(
                          color: Color(0xFF5090E9),
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 1.56,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14002A66),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              icon: Icons.info,
                              title: 'Hướng dẫn sử dụng',
                            ),
                            const Divider(color: Color(0xFFF3F3F5)),
                            _buildMenuItem(
                              icon: Icons.policy,
                              title: 'Điều khoản và chính sách',
                            ),
                            const Divider(color: Color(0xFFF3F3F5)),
                            _buildMenuItem(icon: Icons.star, title: 'Đánh giá'),
                            const Divider(color: Color(0xFFF3F3F5)),
                            _buildMenuItem(
                              icon: Icons.safety_check,
                              title: 'Hướng dẫn an toàn lao động',
                            ),
                            const Divider(color: Color(0xFFF3F3F5)),
                            _buildMenuItem(
                              icon: Icons.support,
                              title: 'Liên hệ & hỗ trợ',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          authService.logout();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.logout,
                                color: Color(0xFFA0A0AA),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Đăng xuất',
                                style: TextStyle(
                                  color: Color(0xFFA0A0AA),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 1.43,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 80), // Thêm padding dưới để tránh bị che bởi Navbar
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 1), // Truyền currentIndex
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF5090E9)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF51515B),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xFFA0A0AA),
          ),
        ],
      ),
    );
  }
}