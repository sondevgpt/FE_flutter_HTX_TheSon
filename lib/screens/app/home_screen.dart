import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Color(0xFFF8FCFF)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header với gradient
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-0.83, -0.55),
                            end: Alignment(0.83, 0.55),
                            colors: [Color(0xFF1667E1), Color(0xFF30B4EC)],
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Opacity(
                                opacity: 0.80,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://placehold.co/430x932",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 39,
                                            height: 18,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  22.96,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              const SizedBox(
                                                width: 32,
                                                height: 32,
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: Image.asset(
                                                  'assets/icons/bell_icon.png', // Thay bằng đường dẫn của biểu tượng chuông
                                                  width: 34,
                                                  height: 34,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 16,
                                                  height: 16,
                                                  padding: const EdgeInsets.all(
                                                    2,
                                                  ),
                                                  decoration: const ShapeDecoration(
                                                    color: Color(0xFFF04437),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          45,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      '12',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 8,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.50,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width - 32,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      user?.userImageAvatar ??
                                                          "https://placehold.co/48x48",
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      width: 1,
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      80,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Xin chào!',
                                                    style: TextStyle(
                                                      color: Color(0xFFF3F3F5),
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.50,
                                                    ),
                                                  ),
                                                  Text(
                                                    user?.name ??
                                                        'Nguyễn Tâm Gia Huy',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.43,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Card chiến dịch quảng cáo (tách ra và đè lên Header)
                Transform.translate(
                  offset: const Offset(
                    0,
                    -70,
                  ), // Điều chỉnh vị trí card "Chiến dịch quảng cáo" (đè lên Header)
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 138, // Tăng chiều cao để chứa nội dung
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x1E006BFF),
                            blurRadius: 16,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Phần text với chiều cao giới hạn
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Chiến dịch quảng cáo',
                                    style: TextStyle(
                                      color: Color(0xFF3E3E46),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 1.6,
                                    ),
                                  ),

                                  const SizedBox(height: 5),
                                  const Text(
                                    'Gia tăng doanh số cùng chiến dịch quảng cáo tự động',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color(0xFF6F707B),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 1.4,
                                    ),
                                  ),

                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFE0F2FE),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x0C101828),
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: const Text(
                                      'Tạo chiến dịch mới',
                                      style: TextStyle(
                                        color: Color(0xFF1EBBFF),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Phần hình ảnh (tăng kích thước)
                          SizedBox(
                            width: 113, // Tăng chiều rộng
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/images/ads.png',
                                height: 110, // Tăng chiều cao
                                width: 110, // Tăng chiều rộng0,
                                // fit: BoxFit.cover, // Sử dụng cover để lấp đầy
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Card chức năng với Transform.translate
                Transform.translate(
                  offset: const Offset(0, -55), // Điều chỉnh vị trí các card chức năng
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 140,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x1E006BFF),
                                          blurRadius: 16,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: const Color(0xFFCFF8FE),
                                          child: Image.asset(
                                            'assets/icons/store_info.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Thông Tin Gian Hàng',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF3E3E46),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 1.43,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 140,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x1E006BFF),
                                          blurRadius: 16,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: const Color(0xFFCFF8FE),
                                          child: Image.asset(
                                            'assets/icons/services.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Sản phẩm Dịch Vụ',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF3E3E46),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 1.43,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 140,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x1E006BFF),
                                          blurRadius: 16,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: const Color(0xFFCFF8FE),
                                          child: Image.asset(
                                            'assets/icons/orders.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Quản lý đơn hàng',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF3E3E46),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 1.43,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UserScreen(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 140,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x1E006BFF),
                                          blurRadius: 16,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: const Color(0xFFCFF8FE),
                                          child: Image.asset(
                                            'assets/icons/account.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Tài khoản',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF3E3E46),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 1.43,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
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
}