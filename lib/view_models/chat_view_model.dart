import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatViewModel extends ChangeNotifier {
  final TextEditingController textController = TextEditingController(text: 'Hai min');
  final List<ChatMessage> messages = [
    ChatMessage(text: 'Selamat Datang di LaundryMu! \nAda yang bisa kami dibantu?', isMe: false, time: '09:30'),
  ];

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    messages.add(
      ChatMessage(
        text: text,
        isMe: true,
        time: '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      ),
    );
    textController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
