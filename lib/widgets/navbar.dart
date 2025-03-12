import 'package:flutter/material.dart';
import '../screens/app/home_screen.dart';
import '../screens/app/user_screen.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;

  const Navbar({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: currentIndex, // Hiển thị tab hiện tại
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá nhân"),
      ],
      onTap: (index) {
        // Tránh chuyển hướng nếu đã ở màn hình hiện tại
        if (index == currentIndex) return;

        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserScreen()),
          );
        }
      },
    );
  }
}