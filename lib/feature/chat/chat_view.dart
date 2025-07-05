import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/public_profile.dart';
import 'package:deu_cis/product/services/model_service/user_chat_messages_service.dart';
import 'package:deu_cis/product/services/socket/socket_service.dart';

class ChatView extends StatefulWidget {
  final int userID;
  final PublicProfile reciverProfile;

  const ChatView({
    Key? key,
    required this.userID,
    required this.reciverProfile,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
  StreamController<List<Map<String, dynamic>>> _streamController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  late SocketService _socketService;
  late IUserChatMessagesService _chatService;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _chatService = UserChatMessagesService();
    _socketService = SocketService();

    _initChat();
  }

  Future<void> _initChat() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Socket'i başlat
      _socketService.init(widget.userID);

      // Önceki mesajları çek
      final previousMessages = await _chatService.getUserChatMessages(
        widget.userID,
        widget.reciverProfile.id!,
      );

      print("Önceki mesajlar: $previousMessages"); // Debug için

      if (previousMessages != null && previousMessages.isNotEmpty) {
        _messages.clear();
        _messages.addAll(previousMessages.map((e) => e.toMap()));
        print("Yüklenen mesaj sayısı: ${_messages.length}");
      }

      // Stream'e ilk verileri gönder
      _streamController.add(List.from(_messages));

      // Loading'i kapat
      setState(() {
        _isLoading = false;
      });

      // Scroll'u en alta kaydır
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });

      // Socket mesaj dinleyicisini kur
      _socketService.onMessageReceived((data) {
        print("SOCKET VERİSİ: $data");
        setState(() {
          _messages.add(data);
        });
        _streamController.add(List.from(_messages));
        _scrollToBottom();
      });
    } catch (e) {
      print("Chat başlatma hatası: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final message = {
      'owner_user_id': widget.userID,
      'receiver_user_id': widget.reciverProfile.id!,
      'message': text,
      'message_type': 'text',
      'upload_at': DateTime.now().toIso8601String(),
    };

    setState(() {
      _messages.add(message);
    });
    _streamController.add(List.from(_messages));
    _controller.clear();
    _scrollToBottom();

    _socketService.sendMessage(
      widget.userID,
      widget.reciverProfile.id!,
      text,
      'text',
    );
  }

  // Tarih formatı için yardımcı fonksiyon
  String _formatMessageTime(dynamic uploadAt) {
    if (uploadAt == null) return '';

    DateTime dateTime;
    if (uploadAt is String) {
      dateTime = DateTime.tryParse(uploadAt) ?? DateTime.now();
    } else if (uploadAt is DateTime) {
      dateTime = uploadAt;
    } else {
      return '';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      // Bugünse sadece saat göster
      return DateFormat('HH:mm').format(dateTime);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // Dünse "Dün" + saat göster
      return 'Dün ${DateFormat('HH:mm').format(dateTime)}';
    } else if (dateTime.year == now.year) {
      // Bu yılsa ay/gün + saat göster
      return DateFormat('dd/MM HH:mm').format(dateTime);
    } else {
      // Farklı yılsa tam tarih
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _streamController.close();
    _socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CachedImage(
              isProfile: true,
              imageUrl: widget.reciverProfile.getImageURL(),
              width: 35,
              height: 35,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "${widget.reciverProfile.title ?? ''} ${widget.reciverProfile.firstName} ${widget.reciverProfile.lastName}",
                style: AppTextStyles.titleTextWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _streamController.stream,
                    initialData: _messages,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          (snapshot.data?.isEmpty ?? true)) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final messages = snapshot.data ?? [];

                      if (messages.isEmpty) {
                        return const Center(
                          child: Text(
                            'Henüz mesaj yok',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final isMine = msg['owner_user_id'] == widget.userID;

                          return Align(
                            alignment: isMine
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: isMine
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 12),
                                  padding: const EdgeInsets.all(12),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.75,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isMine
                                        ? Colors.blue[100]
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(12),
                                      topRight: const Radius.circular(12),
                                      bottomLeft: isMine
                                          ? const Radius.circular(12)
                                          : Radius.zero,
                                      bottomRight: isMine
                                          ? Radius.zero
                                          : const Radius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    msg['message'] ?? '',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                // Zaman bilgisi
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    _formatMessageTime(msg['upload_at']),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Mesaj yaz...',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text('Gönder'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
