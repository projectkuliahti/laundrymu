import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Controller untuk input text
  final TextEditingController _textController = TextEditingController(text: 'Hai min'); // Default "Hai min" sesuai screenshot

  // List mock pesan agar ada tampilan chat-nya
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Halo, ada yang bisa dibantu min?',
      'isMe': false, // Pesan masuk (Admin)
      'time': '09:30',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // ✅ APPBAR CUSTOM (Admin - Laundrystu)
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B499A), // Warna Biru App
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Admin',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Laundrystu',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        centerTitle: false, // Title di kiri biar pas di samping icon (opsional)
        actions: [
          // Ikon Admin (Avatar)
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: const AssetImage('assets/images/Profile Biru.png'), // Ganti dengan foto admin kalau ada
              child: ClipOval(
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      // ✅ BODY CHAT
      body: Column(
        children: [
          // Area Pesan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                );
              },
            ),
          ),

          // ✅ BOTTOM INPUT AREA (Sesuai Screenshot)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, -2)),
              ],
            ),
            child: Row(
              children: [
                // Tombol Bulat 1 (Attachment)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B499A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.attach_file, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 10),
                // Input Text
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tulis pesan...',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Tombol Bulat 2 (Send)
                GestureDetector(
                  onTap: () {
                    if (_textController.text.isNotEmpty) {
                      setState(() {
                        messages.add({
                          'text': _textController.text,
                          'isMe': true,
                          'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                        });
                        _textController.clear();
                      });
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B499A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Chat Bubble
  Widget _buildMessageBubble({required String text, required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF3B499A) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.grey.shade500,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}