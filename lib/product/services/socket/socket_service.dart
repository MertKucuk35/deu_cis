import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket socket;
  Function(Map<String, dynamic>)? _onMessageCallback;

  void init(int userId) {
    socket = IO.io(
      'http://${kIsWeb ? 'localhost' : '10.0.2.2'}:3000',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print('Socket bağlandı');
      socket.emit('register_user', userId);
    });

    socket.on('receive_message', (data) {
      print('Yeni mesaj geldi: $data');
      if (_onMessageCallback != null && data is Map<String, dynamic>) {
        _onMessageCallback!(data);
      }
    });

    socket.onDisconnect((_) {
      print('Socket bağlantısı kesildi');
    });

    socket.onError((error) {
      print('Socket hatası: $error');
    });
  }

  void sendMessage(int ownerId, int receiverId, String message, String type) {
    socket.emit('send_message', {
      'owner_user_id': ownerId,
      'receiver_user_id': receiverId,
      'message': message,
      'message_type': type,
    });
  }

  void onMessageReceived(Function(Map<String, dynamic>) callback) {
    _onMessageCallback = callback;
  }

  void disconnect() {
    socket.disconnect();
    _onMessageCallback = null;
  }
}
