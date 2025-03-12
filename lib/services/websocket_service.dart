import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class WebSocketService {
  late IOWebSocketChannel _channel;

  void connect(context) {
    _channel = IOWebSocketChannel.connect('ws://localhost:3000');
    _channel.stream.listen((message) {
      final data = jsonDecode(message);
      Provider.of<AuthService>(context, listen: false).updateUserFromResponse(data);
    });
  }

  void disconnect() {
    _channel.sink.close();
  }
}