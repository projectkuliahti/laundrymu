import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Notifikasi', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today
            const Text('Today', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 12),
            ..._buildNotificationList([
              {'text': 'Fahmi, Laundry anda sudah selesai', 'time': 'Sekarang', 'status': 'done'},
              {'text': 'Pakaian anda sedang dikemas', 'time': '19.00', 'status': 'packing'},
              {'text': 'Pakaian anda sedang di cuci', 'time': '06.30', 'status': 'washing'},
            ]),
            const SizedBox(height: 24),

            // 25 Maret 2026
            const Text('25 Maret 2026', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 12),
            ..._buildNotificationList([
              {'text': 'Fahmi, Laundry anda sudah selesai', 'time': '20.00', 'status': 'done'},
              {'text': 'Pakaian anda sedang dikemas', 'time': '19.45', 'status': 'packing'},
              {'text': 'Segera cuci pakaian anda sekarang', 'time': '18.30', 'status': 'info'},
              {'text': 'Laundry akan segera selesai!', 'time': '18.15', 'status': 'alert'},
              {'text': 'Pakaian anda sedang di setrika', 'time': '17.23', 'status': 'ironing'},
              {'text': 'Pakaian anda sedang di cuci', 'time': '06.15', 'status': 'washing'},
            ]),
            const SizedBox(height: 24),

            // 20 Maret 2026
            const Text('20 Maret 2026', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 12),
            ..._buildNotificationList([
              {'text': 'Fahmi, Laundry anda sudah selesai', 'time': '15.29', 'status': 'done'},
              {'text': 'Laundry akan segera selesai!', 'time': '14.53', 'status': 'alert'},
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF3B499A),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home_outlined, 'Menu', true, () {}),
            _buildNavItem(Icons.shopping_cart_outlined, '', false, () {}),
            _buildNavItem(Icons.receipt_long_outlined, 'Riwayat', false, () {}),
            _buildNavItem(Icons.person_outline, '', false, () {}),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNotificationList(List<Map<String, dynamic>> items) {
    return items.map((item) {
      String text = item['text'];
      String time = item['time'];
      String status = item['status'];

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, spreadRadius: 1)],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEFF0FF),
              ),
              child: Center(
                child: _buildIconByStatus(status),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: const TextStyle(fontSize: 14, color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // ✅ WIDGET UNTUK MENAMPILKAN ICON BERDASARKAN STATUS
  Widget _buildIconByStatus(String status) {
    String iconPath;
    
    switch (status) {
      case 'done':
        iconPath = 'assets/images/sudah_selesai.png';
        break;
      case 'packing':
      case 'washing':
      case 'ironing':
        iconPath = 'assets/images/sedang_dilakukan.png';
        break;
      case 'info':
      case 'alert':
        iconPath = 'assets/images/segera_dilakukan.png';
        break;
      default:
        iconPath = 'assets/images/sedang_dilakukan.png';
    }

    return Image.asset(
      iconPath,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback icon jika gambar tidak ditemukan
        return Icon(
          Icons.notifications_active,
          size: 20,
          color: Colors.grey.shade600,
        );
      },
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isActive ? 22 : 16, vertical: 12),
        decoration: isActive ? BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? const Color(0xFF3B499A) : Colors.white70, size: 24),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: isActive ? const Color(0xFF3B499A) : Colors.white70, fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ],
        ),
      ),
    );
  }
}