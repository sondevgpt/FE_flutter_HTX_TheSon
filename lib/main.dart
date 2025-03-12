import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';
import 'services/auth_service.dart';
import 'services/websocket_service.dart';
import 'screens/app/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint = (String? message, {int? wrapWidth}) {};
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => WebSocketService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final webSocketService = Provider.of<WebSocketService>(context, listen: false);

    return MaterialApp(
      navigatorKey: navigatorKey, // Thêm navigatorKey
      title: 'HTX SV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        future: authService.checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            webSocketService.connect(context);
            if (authService.currentUser != null) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }
        },
      ),
    );
  }
}