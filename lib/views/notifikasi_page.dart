import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'profil_page.dart';
import 'riwayat_page.dart';
import 'rincian_pemesanan_page.dart';
import '../widgets/compact_bottom_nav.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  late final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(2); // Index 2 = Riwayat

  @override
  void initState() {
    super.initState();
    // Pastikan currentIndex sesuai dengan halaman asal (Riwayat = 2)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentIndexNotifier.value != 2) {
        _currentIndexNotifier.value = 2;
      }
    });
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    if (index == 2) {
      // Sudah di riwayat
      if (_currentIndexNotifier.value != 2) {
        _currentIndexNotifier.value = 2;
      }
      return;
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/dashboard'),
          builder: (_) => const DashboardPage(),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/rincian'),
          builder: (_) => const RincianPesananPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/profil'),
          builder: (_) => const ProfilPage(),
        ),
      );
    }
  }

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
              {'text': 'Segera cuci pakaian anda sekarang', 'time': '18.30', 'status': 'info'},
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

      // ✅ GANTI DENGAN COMPACT BOTTOM NAV
      bottomNavigationBar: CompactBottomNav(
        currentIndexNotifier: _currentIndexNotifier,
        items: [
          BottomNavItem(activeIcon: 'assets/images/Menu Biru.png', inactiveIcon: 'assets/images/Menu Putih.png', label: 'Menu'),
          BottomNavItem(activeIcon: 'assets/images/Keranjang Biru.png', inactiveIcon: 'assets/images/Keranjang Putih.png', label: 'Rincian'),
          BottomNavItem(activeIcon: 'assets/images/Riwayat Biru.png', inactiveIcon: 'assets/images/Riwayat Putih.png', label: 'Riwayat'),
          BottomNavItem(activeIcon: 'assets/images/Profile Biru.png', inactiveIcon: 'assets/images/Profile Putih.png', label: 'Profil'),
        ],
        onItemTapped: _onBottomNavTapped,
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
        return Icon(
          Icons.notifications_active,
          size: 20,
          color: Colors.grey.shade600,
        );
      },
    );
  }
}