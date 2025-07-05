// import 'package:socket_io_client/socket_io_client.dart' as IO;

// void connectSocket() {
//   IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
//     'transports': ['websocket'],
//   });

//   socket.onConnect((_) {
//     print('Bağlandı');
//     socket.emit('send_message', {
//       'receiverSocketId': '<hedef socket id>',
//       'message': 'Merhaba',
//     });
//   });

//   socket.on('receive_message', (data) {
//     print('Yeni mesaj: ${data['message']}');
//   });

//   socket.onDisconnect((_) => print('Bağlantı koptu'));
// }
