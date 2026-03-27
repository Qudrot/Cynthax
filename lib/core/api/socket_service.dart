import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketService {
  IO.Socket? _socket;
  
  void initSocket(String jwtToken) {
    if (_socket != null && _socket!.connected) return;

    String url = dotenv.env['SOCKET_URL'] ?? 'https://api.yourdomain.com';
    
    _socket = IO.io(url, 
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .setAuth({'token': jwtToken})
        .enableAutoConnect()
        .build()
    );

    _socket!.onConnect((_) {
      print('Connected to real-time server');
    });

    _socket!.onDisconnect((_) {
      print('Disconnected from real-time server');
    });

    _socket!.onConnectError((data) => print('Connection Error: $data'));
  }

  void emit(String event, dynamic data) {
    _socket?.emit(event, data);
  }

  void on(String event, Function(dynamic) handler) {
    _socket?.on(event, handler);
  }

  void dispose() {
    _socket?.dispose();
    _socket = null;
  }
}
